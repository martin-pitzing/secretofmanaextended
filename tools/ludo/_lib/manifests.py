"""Pydantic-light manifest schemas (kept dataclass-only to avoid extra deps).

Each pipeline reads a YAML manifest and validates it through these structures.
The schemas mirror what the in-engine loader expects on disk, so a manifest
maps 1:1 to runtime asset locations and naming.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

import yaml

from .config import REPO_ROOT


@dataclass
class AnimationLane:
    state: str
    direction: str
    frame_count: int
    fps: int
    loop: bool
    notes: str = ""

    @property
    def file_basename(self) -> str:
        return f"{self.state}_{self.direction}"


@dataclass
class CharacterManifest:
    id: str
    chapter: str  # ch01..ch12
    faction: str
    art_brief: str
    style_anchor: str  # path to style YAML
    output_dir: str  # res-relative, e.g. art/ch01/characters/primm
    cell_px: int
    lanes: list[AnimationLane]
    palette_notes: str = ""
    silhouette_notes: str = ""
    sources: list[str] = field(default_factory=list)  # docs paths used for prompt context

    @classmethod
    def load(cls, path: Path) -> "CharacterManifest":
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
        lanes = [AnimationLane(**lane) for lane in data["lanes"]]
        return cls(
            id=data["id"],
            chapter=data["chapter"],
            faction=data["faction"],
            art_brief=data["art_brief"],
            style_anchor=data["style_anchor"],
            output_dir=data["output_dir"],
            cell_px=int(data.get("cell_px", 64)),
            lanes=lanes,
            palette_notes=data.get("palette_notes", ""),
            silhouette_notes=data.get("silhouette_notes", ""),
            sources=data.get("sources", []),
        )

    def output_path(self) -> Path:
        return (REPO_ROOT / self.output_dir).resolve()


@dataclass
class MonsterLane:
    state: str   # idle | walk | attack | hurt | defeat | special
    direction: str
    frame_count: int
    fps: int
    loop: bool
    notes: str = ""


@dataclass
class CanonReference:
    """Source artwork that defines what the creature *is*.

    The plan builder picks the entry with role=primary as the `style_image`
    fed to Ludo. Other entries are listed in the prompt as auxiliary hints
    (e.g. "side-facing canon sprite for direction lanes").
    """
    source: str            # human-readable provenance: "wikiofmana.com/wiki/Rabite"
    notes: str = ""        # what this reference represents
    role: str = "primary"  # primary | secondary
    image_url: str = ""    # direct image URL (preferred when stable)
    local_path: str = ""   # repo-relative path to a local copy

    def has_image(self) -> bool:
        return bool(self.image_url or self.local_path)


@dataclass
class MonsterManifest:
    id: str
    canon_name: str   # SoM '93 reference, e.g. "Rabite"
    biome: str
    tier: str         # minor | standard | elite | miniboss | boss
    style_anchor: str
    output_dir: str
    cell_px: int
    art_brief: str
    style_adaptation: str  # how this monster is restyled vs canon
    lanes: list[MonsterLane]
    canon_references: list[CanonReference] = field(default_factory=list)
    stats: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def load(cls, path: Path) -> "MonsterManifest":
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
        lanes = [MonsterLane(**lane) for lane in data["lanes"]]
        refs = [CanonReference(**r) for r in data.get("canon_references", [])]
        return cls(
            id=data["id"],
            canon_name=data["canon_name"],
            biome=data["biome"],
            tier=data.get("tier", "standard"),
            style_anchor=data["style_anchor"],
            output_dir=data["output_dir"],
            cell_px=int(data.get("cell_px", 128)),
            art_brief=data["art_brief"],
            style_adaptation=data.get("style_adaptation", ""),
            lanes=lanes,
            canon_references=refs,
            stats=data.get("stats", {}),
        )

    def output_path(self) -> Path:
        return (REPO_ROOT / self.output_dir).resolve()

    def primary_canon(self) -> CanonReference | None:
        for r in self.canon_references:
            if r.role == "primary" and r.has_image():
                return r
        for r in self.canon_references:
            if r.has_image():
                return r
        return None
