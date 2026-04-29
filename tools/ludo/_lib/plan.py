"""Job plan format — pipelines emit these, the MCP executor consumes them.

A plan is a deterministic, hashable description of every Ludo job a pipeline
needs to run. It is decoupled from transport: today the executor is Claude
running in this repo via the Ludo MCP server; tomorrow it could be a headless
worker speaking the real REST API. The plan format does not change.

Plan files live at:   data/pipelines/_manifest/runs/{plan_id}.plan.yaml
Result files live at: data/pipelines/_manifest/runs/{plan_id}.results.yaml
Both directories are gitignored — they are transient run artefacts.
"""
from __future__ import annotations

import datetime as dt
import uuid
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Any, Literal

import yaml

from .config import MANIFEST_DIR

RUNS_DIR = MANIFEST_DIR / "runs"

# What kind of MCP call sequence the executor should run for a given step.
StepIntent = Literal[
    "animation_lane",   # generateWithStyle -> removeBackground -> generatePose -> animateSprite
    "portrait_emotion", # createImage -> removeBackground
    "biome_kind",       # generateWithStyle
]


@dataclass
class PlanStep:
    step_id: str
    cache_key: str
    intent: StepIntent
    parameters: dict[str, Any]
    expected_outputs: dict[str, Any]  # {output_dir, basename, frame_count?} per intent


@dataclass
class Plan:
    plan_id: str
    pipeline: str
    manifest_path: str
    style_anchor_id: str
    style_anchor_references: list[str]
    default_output_root: str
    created_at: str
    steps: list[PlanStep] = field(default_factory=list)

    @classmethod
    def new(
        cls,
        *,
        pipeline: str,
        manifest_path: Path,
        style_anchor_id: str,
        style_anchor_references: list[Path],
        default_output_root: Path,
    ) -> "Plan":
        slug = manifest_path.stem
        return cls(
            plan_id=f"{pipeline}-{slug}-{uuid.uuid4().hex[:8]}",
            pipeline=pipeline,
            manifest_path=str(manifest_path.as_posix()),
            style_anchor_id=style_anchor_id,
            style_anchor_references=[str(p.as_posix()) for p in style_anchor_references],
            default_output_root=str(default_output_root.as_posix()),
            created_at=dt.datetime.now(dt.timezone.utc).isoformat(timespec="seconds"),
        )

    def add(self, step: PlanStep) -> None:
        self.steps.append(step)

    def to_dict(self) -> dict[str, Any]:
        d = asdict(self)
        return d

    def save(self) -> Path:
        RUNS_DIR.mkdir(parents=True, exist_ok=True)
        out = RUNS_DIR / f"{self.plan_id}.plan.yaml"
        out.write_text(
            yaml.safe_dump(self.to_dict(), sort_keys=False, allow_unicode=True),
            encoding="utf-8",
        )
        return out


def load_plan(path: Path) -> Plan:
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    steps = [PlanStep(**s) for s in data.pop("steps", [])]
    return Plan(steps=steps, **data)


def load_results(path: Path) -> dict[str, Any]:
    return yaml.safe_load(path.read_text(encoding="utf-8")) or {}
