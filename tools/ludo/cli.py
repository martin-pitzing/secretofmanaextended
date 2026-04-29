"""Entry point: `python -m tools.ludo.cli <command> <manifest>`.

Pipelines emit job plans that the MCP executor (Claude in this repo, calling
the Ludo MCP server tools) consumes. Commands:

    plan-character|plan-monster|plan-portrait|plan-biome <manifest>
        Build a job plan and write it to data/pipelines/_manifest/runs/.

    dry-character|dry-monster|dry-portrait|dry-biome <manifest>
        Print the plan to stdout without writing anything.

    ingest <plan.yaml> <results.yaml>
        Consume the executor's results, download images, update the audit
        ledger, and emit SpriteFrames .tres files for monster plans.

    list-plans
        List plan files awaiting execution / ingest.
"""
from __future__ import annotations

from pathlib import Path

import typer
from rich.console import Console
from rich.table import Table

from . import biome_pipeline, character_pipeline, monster_pipeline, portrait_pipeline
from ._lib.ingest import ingest as ingest_plan
from ._lib.plan import RUNS_DIR, load_plan

app = typer.Typer(add_completion=False, help="Ludo.ai pipelines for Secret of Mana Extended")
console = Console()


# ---- plan emitters ----------------------------------------------------------


@app.command("plan-character")
def plan_character(manifest: Path) -> None:
    character_pipeline.emit_plan(manifest)


@app.command("plan-monster")
def plan_monster(manifest: Path) -> None:
    monster_pipeline.emit_plan(manifest)


@app.command("plan-portrait")
def plan_portrait(manifest: Path) -> None:
    portrait_pipeline.emit_plan(manifest)


@app.command("plan-biome")
def plan_biome(manifest: Path) -> None:
    biome_pipeline.emit_plan(manifest)


# ---- dry runs ---------------------------------------------------------------


@app.command("dry-character")
def dry_character(manifest: Path) -> None:
    character_pipeline.dry_run(manifest)


@app.command("dry-monster")
def dry_monster(manifest: Path) -> None:
    monster_pipeline.dry_run(manifest)


@app.command("dry-portrait")
def dry_portrait(manifest: Path) -> None:
    portrait_pipeline.dry_run(manifest)


@app.command("dry-biome")
def dry_biome(manifest: Path) -> None:
    biome_pipeline.dry_run(manifest)


# ---- ingest + listing -------------------------------------------------------


@app.command()
def ingest(plan: Path, results: Path) -> None:
    """Consume MCP executor results and write outputs + audit."""
    ingest_plan(plan, results)


@app.command("list-plans")
def list_plans() -> None:
    if not RUNS_DIR.exists():
        console.print("[dim]no plans yet[/]")
        return
    table = Table(title="Pending plans")
    table.add_column("plan_id")
    table.add_column("pipeline")
    table.add_column("steps", justify="right")
    table.add_column("manifest")
    table.add_column("results?")
    for p in sorted(RUNS_DIR.glob("*.plan.yaml")):
        plan = load_plan(p)
        results_path = p.with_name(p.name.replace(".plan.", ".results."))
        table.add_row(
            plan.plan_id,
            plan.pipeline,
            str(len(plan.steps)),
            plan.manifest_path,
            "yes" if results_path.exists() else "—",
        )
    console.print(table)


if __name__ == "__main__":
    app()
