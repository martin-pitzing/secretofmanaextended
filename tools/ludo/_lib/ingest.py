"""Consume a {plan_id}.results.yaml emitted by the MCP executor.

Results format (one entry per plan step):

    plan_id: monster-rabite-abc12345
    results:
      - step_id: idle_down
        status: completed
        job_ids: [j1, j2, j3]
        # animation_lane — provide ONE of:
        frame_urls: [https://..., https://...]            # pre-sliced frames
        spritesheet_url: https://...                      # full sheet, ingest will slice
        num_frames: 4                                     # required with spritesheet_url
        grid: [2, 2]                                      # optional; default sqrt(num_frames)
        frame_size: 64                                    # optional; downscale after slice
        keep_frames: [0, 2]                               # optional; subset to keep
        # portrait_emotion / biome_kind:
        image_url: https://...

Ingest downloads + slices as needed, records each file in
data/pipelines/_manifest/manifest.yaml, and (for monster plans) emits a
SpriteFrames .tres so the runtime can pick up the atlas.
"""
from __future__ import annotations

import math
from pathlib import Path
from typing import Any

import httpx
from PIL import Image
from rich.console import Console

from .cache import JobCache
from .config import CACHE_DIR, REPO_ROOT
from .manifest import record
from .plan import Plan, PlanStep, load_plan, load_results

console = Console()
SPRITESHEET_CACHE = CACHE_DIR / "spritesheets"


def ingest(plan_path: Path, results_path: Path) -> None:
    plan = load_plan(plan_path)
    results = load_results(results_path)
    if results.get("plan_id") and results["plan_id"] != plan.plan_id:
        raise RuntimeError(
            f"Results plan_id {results['plan_id']} does not match plan {plan.plan_id}"
        )

    by_step = {r["step_id"]: r for r in results.get("results", [])}
    namespace = f"{plan.pipeline}/{Path(plan.manifest_path).stem}"
    cache = JobCache(namespace)
    written: list[Path] = []
    monster_lane_files: dict[str, list[Path]] = {}
    monster_lane_meta: dict[str, dict[str, Any]] = {}

    with httpx.Client(timeout=120) as http:
        for step in plan.steps:
            r = by_step.get(step.step_id)
            if not r:
                console.print(f"[yellow]skip[/] {step.step_id} (no result)")
                continue
            if r.get("status") != "completed":
                console.print(f"[red]skip[/] {step.step_id} (status={r.get('status')})")
                continue

            files = _ingest_step(http, plan, step, r)
            for f in files:
                rel = _repo_rel(f)
                record(
                    output_path=Path(rel),
                    pipeline=plan.pipeline,
                    source_manifest=Path(plan.manifest_path),
                    prompt_hash=step.cache_key,
                    style_anchor=plan.style_anchor_id,
                    job_id=",".join(r.get("job_ids", []) or []),
                )
                written.append(f)

            cache.put(
                step.cache_key,
                {
                    "step_id": step.step_id,
                    "job_ids": r.get("job_ids", []),
                    "files": [str(p.as_posix()) for p in files],
                },
            )

            if step.expected_outputs.get("emit_sprite_frames"):
                monster_lane_files[step.step_id] = files
                monster_lane_meta[step.step_id] = step.expected_outputs

    if monster_lane_files:
        _emit_sprite_frames(plan, monster_lane_files, monster_lane_meta)

    console.print(f"[green]ingested[/] {len(written)} files for plan {plan.plan_id}")


def _ingest_step(
    http: httpx.Client, plan: Plan, step: PlanStep, r: dict[str, Any]
) -> list[Path]:
    eo = step.expected_outputs
    if step.intent == "animation_lane":
        out_dir = Path(eo["output_dir"])
        out_dir.mkdir(parents=True, exist_ok=True)
        if r.get("frame_urls"):
            return _ingest_frame_urls(http, r["frame_urls"], out_dir, eo["basename"])
        if r.get("spritesheet_url"):
            return _ingest_spritesheet(
                http=http,
                url=r["spritesheet_url"],
                num_frames=int(r["num_frames"]),
                grid=tuple(r["grid"]) if r.get("grid") else None,
                frame_size=int(r["frame_size"]) if r.get("frame_size") else None,
                keep_frames=r.get("keep_frames"),
                out_dir=out_dir,
                basename=eo["basename"],
                cache_key=f"{plan.pipeline}-{Path(plan.manifest_path).stem}-{step.step_id}",
            )
        raise ValueError(
            f"animation_lane step '{step.step_id}' has neither frame_urls nor spritesheet_url"
        )
    if step.intent in ("portrait_emotion", "biome_kind"):
        url = r.get("image_url")
        target = Path(eo["output_path"])
        if not url:
            return []
        target.parent.mkdir(parents=True, exist_ok=True)
        _download(http, url, target)
        return [target]
    raise ValueError(f"Unknown intent: {step.intent}")


def _ingest_frame_urls(
    http: httpx.Client, urls: list[str], out_dir: Path, basename: str
) -> list[Path]:
    files: list[Path] = []
    for idx, url in enumerate(urls):
        target = out_dir / f"{basename}_{idx}.png"
        _download(http, url, target)
        files.append(target)
    return files


def _ingest_spritesheet(
    *,
    http: httpx.Client,
    url: str,
    num_frames: int,
    grid: tuple[int, int] | None,
    frame_size: int | None,
    keep_frames: list[int] | None,
    out_dir: Path,
    basename: str,
    cache_key: str,
) -> list[Path]:
    if grid is None:
        side = int(math.isqrt(num_frames))
        if side * side != num_frames:
            raise ValueError(
                f"num_frames={num_frames} is not a perfect square; "
                f"specify `grid: [cols, rows]` in the result"
            )
        grid = (side, side)

    SPRITESHEET_CACHE.mkdir(parents=True, exist_ok=True)
    suffix = Path(url).suffix or ".webp"
    sheet_path = SPRITESHEET_CACHE / f"{cache_key}{suffix}"
    _download(http, url, sheet_path)

    sheet = Image.open(sheet_path).convert("RGBA")
    W, H = sheet.size
    cols, rows = grid
    fw, fh = W // cols, H // rows
    if fw == 0 or fh == 0:
        raise ValueError(f"Spritesheet {W}x{H} cannot be split into {cols}x{rows}")

    indices = keep_frames if keep_frames else list(range(num_frames))
    files: list[Path] = []
    for out_idx, src_idx in enumerate(indices):
        if src_idx >= num_frames:
            raise ValueError(f"keep_frames index {src_idx} >= num_frames {num_frames}")
        r, c = divmod(src_idx, cols)
        box = (c * fw, r * fh, (c + 1) * fw, (r + 1) * fh)
        frame = sheet.crop(box)
        if frame_size and (frame.size[0] != frame_size or frame.size[1] != frame_size):
            frame = frame.resize((frame_size, frame_size), Image.NEAREST)
        target = out_dir / f"{basename}_{out_idx}.png"
        frame.save(target, format="PNG")
        files.append(target)

    console.print(
        f"  sliced {sheet_path.name} ({W}x{H}, {cols}x{rows}) -> "
        f"{len(files)} frame(s) at {basename}_*.png"
    )
    return files


def _download(http: httpx.Client, url: str, target: Path) -> None:
    target.parent.mkdir(parents=True, exist_ok=True)
    with http.stream("GET", url) as resp:
        resp.raise_for_status()
        with target.open("wb") as fh:
            for chunk in resp.iter_bytes():
                fh.write(chunk)


def _repo_rel(p: Path) -> str:
    try:
        return str(p.resolve().relative_to(REPO_ROOT).as_posix())
    except ValueError:
        return str(p.as_posix())


def _emit_sprite_frames(
    plan: Plan,
    lane_files: dict[str, list[Path]],
    lane_meta: dict[str, dict[str, Any]],
) -> None:
    monster_id = next(iter(lane_meta.values())).get("monster_id")
    if not monster_id:
        return
    out_root = Path(plan.default_output_root)
    target = out_root / f"{monster_id}.tres"

    ext_resources: list[str] = []
    frame_lookup: dict[Path, str] = {}
    next_id = 1
    for files in lane_files.values():
        for f in files:
            ext_resources.append(
                f'[ext_resource type="Texture2D" path="res://{_res_rel(f)}" id="{next_id}"]'
            )
            frame_lookup[f] = str(next_id)
            next_id += 1

    animations: list[str] = []
    for lane_key, files in lane_files.items():
        meta = lane_meta[lane_key]
        frames_repr = ", ".join(
            f'{{ "duration": 1.0, "texture": ExtResource("{frame_lookup[f]}") }}'
            for f in files
        )
        animations.append(
            "{\n"
            f'    "frames": [{frames_repr}],\n'
            f'    "loop": {str(bool(meta.get("loop"))).lower()},\n'
            f'    "name": &"{lane_key}",\n'
            f'    "speed": {float(meta.get("fps", 8))}\n'
            "}"
        )

    body = (
        '[gd_resource type="SpriteFrames" load_steps=2 format=3]\n\n'
        + "\n".join(ext_resources)
        + "\n\n[resource]\nanimations = [\n"
        + ",\n".join(animations)
        + "\n]\n"
    )
    target.write_text(body, encoding="utf-8")
    console.print(f"  wrote SpriteFrames -> {target}")


def _res_rel(p: Path) -> str:
    parts = list(p.resolve().parts)
    if "game" in parts:
        idx = parts.index("game")
        return "/".join(parts[idx + 1 :])
    return p.as_posix()
