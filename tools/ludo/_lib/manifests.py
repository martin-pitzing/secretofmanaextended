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
    stats: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def load(cls, path: Path) -> "MonsterManifest":
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
        lanes = [MonsterLane(**lane) for lane in data["lanes"]]
        return cls(
            id=data["id"],
            canon_name=data["canon_name"],
            biome=data["biome"],
            tier=data.get("tier", "standard"),
            style_anchor=data["style_anchor"],
            output_dir=data["output_dir"],
            cell_px=int(data.get("cell_px", 64)),
            art_brief=data["art_brief"],
            style_adaptation=data.get("style_adaptation", ""),
            lanes=lanes,
            stats=data.get("stats", {}),
        )

    def output_path(self) -> Path:
        return (REPO_ROOT / self.output_dir).resolve()
