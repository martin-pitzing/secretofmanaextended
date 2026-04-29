"""Transcode a canon reference into a Ludo-friendly style_image data URL.

Empirically the Ludo `generateWithStyle` endpoint rejects PNGs that carry an
alpha channel or ICC profile metadata (HTTP 400 "Invalid image data"). This
helper transcodes any source image (PNG/SVG/etc) through Pillow into a clean
JPEG: RGB only, no metadata, capped at 256px on the longest edge. The result
is a `data:image/jpeg;base64,...` URL ready to drop into the API request.
"""
from __future__ import annotations

import base64
import io
from pathlib import Path

from PIL import Image

from .config import REPO_ROOT

MAX_EDGE = 256
JPEG_QUALITY = 90


def to_data_url(local_path: str) -> str:
    abs_path = Path(local_path)
    if not abs_path.is_absolute():
        abs_path = (REPO_ROOT / local_path).resolve()
    if not abs_path.exists():
        raise FileNotFoundError(f"canon reference not found: {abs_path}")

    img = Image.open(abs_path).convert("RGB")
    img.thumbnail((MAX_EDGE, MAX_EDGE), Image.LANCZOS)

    buf = io.BytesIO()
    img.save(buf, format="JPEG", quality=JPEG_QUALITY, optimize=True)
    b64 = base64.b64encode(buf.getvalue()).decode("ascii")
    return f"data:image/jpeg;base64,{b64}"


def render_for_plan(plan_canon_image: str) -> str:
    """Convert a plan's `canon_style_image` field into a usable data URL.

    Accepts either a direct https URL (returned unchanged) or a repo-relative
    local path (transcoded). Empty string returns empty.
    """
    if not plan_canon_image:
        return ""
    if plan_canon_image.startswith(("http://", "https://", "data:")):
        return plan_canon_image
    return to_data_url(plan_canon_image)
