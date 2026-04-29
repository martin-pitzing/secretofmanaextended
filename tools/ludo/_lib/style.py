"""Resolve a style anchor declaration into concrete reference assets.

A style anchor YAML lists one or more reference images (the Randi SVG masters in
pictures_artworks/, or biome reference frames). Pipelines load the anchor and
forward its references into Ludo `generateWithStyle` / `animateSprite` calls so
output stays cohesive.
"""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

import yaml

from .config import REPO_ROOT

PIPELINES_ROOT = REPO_ROOT / "data" / "pipelines"


def resolve_anchor_path(manifest_path: Path, anchor_ref: str) -> Path:
    """Style anchor refs are always relative to data/pipelines/."""
    candidate = (PIPELINES_ROOT / anchor_ref).resolve()
    if candidate.exists():
        return candidate
    # fallback: relative to the manifest's own directory
    fallback = (manifest_path.parent / anchor_ref).resolve()
    if fallback.exists():
        return fallback
    raise FileNotFoundError(
        f"Could not resolve style anchor '{anchor_ref}' from manifest "
        f"{manifest_path}. Tried {candidate} and {fallback}."
    )


@dataclass(frozen=True)
class StyleAnchor:
    id: str
    description: str
    references: list[Path]
    palette_notes: str
    rendering_notes: str

    @classmethod
    def load(cls, path: Path) -> "StyleAnchor":
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
        refs = [
            (REPO_ROOT / r).resolve() if not Path(r).is_absolute() else Path(r)
            for r in data.get("references", [])
        ]
        missing = [str(r) for r in refs if not r.exists()]
        if missing:
            raise FileNotFoundError(
                f"Style anchor {path} references missing files: {missing}"
            )
        return cls(
            id=data["id"],
            description=data.get("description", ""),
            references=refs,
            palette_notes=data.get("palette_notes", ""),
            rendering_notes=data.get("rendering_notes", ""),
        )
