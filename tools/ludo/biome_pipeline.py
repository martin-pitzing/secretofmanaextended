"""Build a biome-kind plan for an environment kit manifest."""
from __future__ import annotations

from pathlib import Path

import yaml
from rich.console import Console

from ._lib.cache import JobCache
from ._lib.config import REPO_ROOT
from ._lib.plan import Plan, PlanStep
from ._lib.style import StyleAnchor, resolve_anchor_path

console = Console()


def build_plan(manifest_path: Path) -> Plan:
    data = yaml.safe_load(manifest_path.read_text(encoding="utf-8"))
    anchor = StyleAnchor.load(resolve_anchor_path(manifest_path, data["style_anchor"]))
    out_root = (REPO_ROOT / data["output_dir"]).resolve()
    cache = JobCache(f"biome/{data['id']}")

    plan = Plan.new(
        pipeline="biome",
        manifest_path=manifest_path,
        style_anchor_id=anchor.id,
        style_anchor_references=anchor.references,
        default_output_root=out_root,
    )

    for kind in data["kinds"]:
        for v in range(kind.get("variants", 1)):
            params = {
                "region": data["id"],
                "kind": kind["kind"],
                "variant_index": v,
                "art_brief": kind.get("art_brief", ""),
                "style_references": [str(p) for p in anchor.references],
            }
            target = out_root / f"{kind['kind']}_{v}.png"
            plan.add(
                PlanStep(
                    step_id=f"{kind['kind']}_{v}",
                    cache_key=cache.key(params),
                    intent="biome_kind",
                    parameters=params,
                    expected_outputs={
                        "output_path": str(target.as_posix()),
                    },
                )
            )
    return plan


def emit_plan(manifest_path: Path) -> Path:
    plan = build_plan(manifest_path)
    out = plan.save()
    console.print(f"[bold]biome[/] [green]{Path(plan.manifest_path).stem}[/] -> plan {out}")
    console.print(f"  steps: {len(plan.steps)}")
    return out


def dry_run(manifest_path: Path) -> None:
    plan = build_plan(manifest_path)
    console.print(f"[bold]biome[/] [green]{Path(plan.manifest_path).stem}[/]")
    console.print(f"  output root : {plan.default_output_root}")
    console.print(f"  steps       : {len(plan.steps)}")
    for step in plan.steps:
        console.print(f"  - {step.step_id}  ->  {step.expected_outputs['output_path']}")
    console.print("[yellow]dry-run, no MCP calls made[/]")
