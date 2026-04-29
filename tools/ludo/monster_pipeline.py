"""Build an animation-lane plan for a monster manifest.

Same intent as character (animation_lane), but with biome-style adaptation
notes folded into the prompt. After ingest, a SpriteFrames .tres is emitted
so PrototypeMonster can load by id.
"""
from __future__ import annotations

from dataclasses import asdict
from pathlib import Path

from rich.console import Console

from ._lib.cache import JobCache
from ._lib.manifests import MonsterManifest
from ._lib.plan import Plan, PlanStep
from ._lib.style import StyleAnchor, resolve_anchor_path

console = Console()


def build_plan(manifest_path: Path) -> Plan:
    manifest = MonsterManifest.load(manifest_path)
    anchor = StyleAnchor.load(resolve_anchor_path(manifest_path, manifest.style_anchor))
    out_root = manifest.output_path()
    cache = JobCache(f"monster/{manifest.id}")

    plan = Plan.new(
        pipeline="monster",
        manifest_path=manifest_path,
        style_anchor_id=anchor.id,
        style_anchor_references=anchor.references,
        default_output_root=out_root,
    )

    for lane in manifest.lanes:
        params = {
            "subject_id": manifest.id,
            "canon_name": manifest.canon_name,
            "biome": manifest.biome,
            "tier": manifest.tier,
            "art_brief": manifest.art_brief,
            "style_adaptation": manifest.style_adaptation,
            "lane": asdict(lane),
            "cell_px": manifest.cell_px,
            "style_references": [str(p) for p in anchor.references],
        }
        plan.add(
            PlanStep(
                step_id=f"{lane.state}_{lane.direction}",
                cache_key=cache.key(params),
                intent="animation_lane",
                parameters=params,
                expected_outputs={
                    "output_dir": str(out_root.as_posix()),
                    "basename": f"{lane.state}_{lane.direction}",
                    "frame_count": lane.frame_count,
                    "fps": lane.fps,
                    "loop": lane.loop,
                    "cell_px": manifest.cell_px,
                    "emit_sprite_frames": True,
                    "monster_id": manifest.id,
                },
            )
        )
    return plan


def emit_plan(manifest_path: Path) -> Path:
    plan = build_plan(manifest_path)
    out = plan.save()
    console.print(f"[bold]monster[/] [magenta]{Path(plan.manifest_path).stem}[/] -> plan {out}")
    console.print(f"  steps: {len(plan.steps)} | biome anchor: {plan.style_anchor_id}")
    return out


def dry_run(manifest_path: Path) -> None:
    plan = build_plan(manifest_path)
    console.print(f"[bold]monster[/] [magenta]{Path(plan.manifest_path).stem}[/]")
    console.print(f"  output root : {plan.default_output_root}")
    console.print(f"  biome anchor: {plan.style_anchor_id}")
    console.print(f"  steps       : {len(plan.steps)}")
    for step in plan.steps:
        eo = step.expected_outputs
        console.print(
            f"  - {step.step_id} x{eo['frame_count']} @ {eo['fps']}fps (cache {step.cache_key[:8]})"
        )
    console.print("[yellow]dry-run, no MCP calls made[/]")
