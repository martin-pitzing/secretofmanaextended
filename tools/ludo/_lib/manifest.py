"""Audit log of every asset emitted by a pipeline.

Single committed manifest at data/pipelines/_manifest/manifest.yaml records, for
each generated file, the source pipeline manifest, prompt hash, style anchor,
Ludo job id, and creation timestamp. Per-run transient logs go under
runs/ (gitignored) so noisy reruns don't bloat history.
"""
from __future__ import annotations

import datetime as dt
from pathlib import Path
from typing import Any

import yaml

from .config import MANIFEST_DIR

MANIFEST_FILE = MANIFEST_DIR / "manifest.yaml"


def _load() -> dict[str, Any]:
    if not MANIFEST_FILE.exists():
        return {"schema_version": 1, "assets": {}}
    return yaml.safe_load(MANIFEST_FILE.read_text(encoding="utf-8")) or {
        "schema_version": 1,
        "assets": {},
    }


def _save(data: dict[str, Any]) -> None:
    MANIFEST_FILE.parent.mkdir(parents=True, exist_ok=True)
    MANIFEST_FILE.write_text(
        yaml.safe_dump(data, sort_keys=True, allow_unicode=True),
        encoding="utf-8",
    )


def record(
    *,
    output_path: Path,
    pipeline: str,
    source_manifest: Path,
    prompt_hash: str,
    style_anchor: str,
    job_id: str,
) -> None:
    data = _load()
    rel = str(output_path.as_posix())
    data["assets"][rel] = {
        "pipeline": pipeline,
        "source_manifest": str(source_manifest.as_posix()),
        "prompt_hash": prompt_hash,
        "style_anchor": style_anchor,
        "ludo_job_id": job_id,
        "generated_at": dt.datetime.now(dt.timezone.utc).isoformat(timespec="seconds"),
    }
    _save(data)


def write_run_log(run_id: str, entries: list[dict[str, Any]]) -> Path:
    runs_dir = MANIFEST_DIR / "runs"
    runs_dir.mkdir(parents=True, exist_ok=True)
    out = runs_dir / f"{run_id}.yaml"
    out.write_text(
        yaml.safe_dump({"run_id": run_id, "entries": entries}, sort_keys=False),
        encoding="utf-8",
    )
    return out
