"""Content-hashed cache for Ludo jobs so reruns don't re-bill identical inputs."""
from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any

from .config import CACHE_DIR


def _hash(payload: dict[str, Any]) -> str:
    blob = json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(blob).hexdigest()[:32]


class JobCache:
    def __init__(self, namespace: str) -> None:
        self.dir = CACHE_DIR / namespace
        self.dir.mkdir(parents=True, exist_ok=True)

    def key(self, payload: dict[str, Any]) -> str:
        return _hash(payload)

    def path(self, key: str) -> Path:
        return self.dir / f"{key}.json"

    def get(self, key: str) -> dict[str, Any] | None:
        p = self.path(key)
        if not p.exists():
            return None
        return json.loads(p.read_text(encoding="utf-8"))

    def put(self, key: str, value: dict[str, Any]) -> None:
        self.path(key).write_text(
            json.dumps(value, indent=2, sort_keys=True), encoding="utf-8"
        )
