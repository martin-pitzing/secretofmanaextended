"""Build an animation-lane plan for a character manifest.

Output: a job plan describing every lane (idle/walk/run/attack/jump/hit per
direction). The executor runs the four-step MCP sequence per lane and writes
PNGs back via `cli ingest`.
"""
from __future__ import annotations

from dataclasses import asdict
from pathlib import Path

from rich.console import Console

from ._lib.cache import JobCache
from ._lib.manifests import CharacterManifest
from ._lib.plan import Plan, PlanStep
from ._lib.style import StyleAnchor, resolve_anchor_path

console = Console()


def build_plan(manifest_path: Path) -> Plan:
    manifest = CharacterManifest.load(manifest_path)
    anchor = StyleAnchor.load(resolve_anchor_path(manifest_path, manifest.style_anchor))
    out_root = manifest.output_path()
    cache = JobCache(f"character/{manifest.id}")

    plan = Plan.new(
        pipeline="character",
        manifest_path=manifest_path,
        style_anchor_id=anchor.id,
        style_anchor_references=anchor.references,
        default_output_root=out_root,
    )

    for lane in manifest.lanes:
        params = {
            "subject_id": manifest.id,
            "chapter": manifest.chapter,
            "faction": manifest.faction,
            "art_brief": manifest.art_brief,
            "palette_notes": manifest.palette_notes,
            "silhouette_notes": manifest.silhouette_notes,
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
                    "basename": lane.file_basename,
                    "frame_count": lane.frame_count,
                    "fps": lane.fps,
                    "loop": lane.loop,
                    "cell_px": manifest.cell_px,
                },
            )
        )
    return plan


def emit_plan(manifest_path: Path) -> Path:
    plan = build_plan(manifest_path)
    out = plan.save()
    console.print(f"[bold]character[/] [cyan]{Path(plan.manifest_path).stem}[/] -> plan {out}")
    console.print(f"  steps: {len(plan.steps)} | style anchor: {plan.style_anchor_id}")
    return out


def dry_run(manifest_path: Path) -> None:
    plan = build_plan(manifest_path)
    console.print(f"[bold]character[/] [cyan]{Path(plan.manifest_path).stem}[/]")
    console.print(f"  output root : {plan.default_output_root}")
    console.print(f"  style anchor: {plan.style_anchor_id} ({len(plan.style_anchor_references)} refs)")
    console.print(f"  steps       : {len(plan.steps)}")
    for step in plan.steps:
        eo = step.expected_outputs
        console.print(
            f"  - {step.step_id} x{eo['frame_count']} @ {eo['fps']}fps (cache {step.cache_key[:8]})"
        )
    console.print("[yellow]dry-run, no MCP calls made[/]")
