"""Pipeline configuration loaded from environment + .env, with .mcp.json fallback."""
from __future__ import annotations

import json
import os
import re
from dataclasses import dataclass
from pathlib import Path

from dotenv import load_dotenv

REPO_ROOT = Path(__file__).resolve().parents[3]
TOOLS_DIR = REPO_ROOT / "tools" / "ludo"
CACHE_DIR = TOOLS_DIR / ".cache"
MANIFEST_DIR = REPO_ROOT / "data" / "pipelines" / "_manifest"
MCP_CONFIG = REPO_ROOT / ".mcp.json"


def _key_from_mcp() -> str:
    """Pull the Ludo API key from .mcp.json so it's only stored in one place.

    Expected header form: "Authentication": "ApiKey <uuid>". The file is
    gitignored, so reading it on the local box is safe.
    """
    if not MCP_CONFIG.exists():
        return ""
    try:
        data = json.loads(MCP_CONFIG.read_text(encoding="utf-8"))
    except Exception:
        return ""
    server = (data.get("mcpServers") or {}).get("ludo") or {}
    headers = server.get("headers") or {}
    raw = headers.get("Authentication") or headers.get("Authorization") or ""
    match = re.search(r"(?:ApiKey|Bearer)\s+([\w\-]+)", raw)
    return match.group(1) if match else ""


@dataclass(frozen=True)
class LudoConfig:
    api_key: str
    api_base: str
    auth_header_name: str
    auth_header_scheme: str
    request_timeout: int
    poll_interval: float
    poll_max_attempts: int

    @property
    def auth_header_value(self) -> str:
        return f"{self.auth_header_scheme} {self.api_key}".strip()

    @classmethod
    def load(cls) -> "LudoConfig":
        load_dotenv(TOOLS_DIR / ".env", override=False)
        api_key = os.environ.get("LUDO_API_KEY", "").strip()
        if not api_key:
            api_key = _key_from_mcp()
        if not api_key:
            raise RuntimeError(
                "LUDO_API_KEY is not set and could not be read from .mcp.json. "
                "Copy tools/ludo/.env.example to tools/ludo/.env and fill in "
                "the key (file is gitignored)."
            )
        return cls(
            api_key=api_key,
            api_base=os.environ.get("LUDO_API_BASE", "https://api.ludo.ai").rstrip("/"),
            auth_header_name=os.environ.get("LUDO_AUTH_HEADER", "Authentication"),
            auth_header_scheme=os.environ.get("LUDO_AUTH_SCHEME", "ApiKey"),
            request_timeout=int(os.environ.get("LUDO_REQUEST_TIMEOUT", "120")),
            poll_interval=float(os.environ.get("LUDO_POLL_INTERVAL", "4")),
            poll_max_attempts=int(os.environ.get("LUDO_POLL_MAX_ATTEMPTS", "120")),
        )
