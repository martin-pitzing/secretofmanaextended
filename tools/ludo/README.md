# Ludo.ai generation pipelines

Python-driven pipelines that produce character animation suites, monster atlases,
dialogue portraits, and biome backdrops for the Godot project.

## How it works (MCP-driven flow)

The pipelines are decoupled from transport. Today they run through Claude Code's
Ludo MCP server (the connection configured in [.mcp.json](../../.mcp.json)). A
headless REST runner is a future option once we have real Ludo REST docs.

The flow has three stages:

1. **Plan** — Python reads a manifest, builds a deterministic job plan,
   and writes it to `data/pipelines/_manifest/runs/{plan_id}.plan.yaml`.
2. **Execute** — Claude (in this repo, in a chat session) reads the plan and
   runs each step's MCP tool sequence on `mcp.ludo.ai`. As results arrive,
   Claude writes them to `data/pipelines/_manifest/runs/{plan_id}.results.yaml`.
3. **Ingest** — Python consumes the results, downloads images to the paths the
   plan declared, updates the audit ledger, and (for monster plans) emits a
   Godot `SpriteFrames .tres` so the runtime picks up the atlas.

## Pipelines

- `character_pipeline` — full 16-lane animation suite per cast member. Output
  naming matches `game/scripts/prototype/player_visual.gd`
  (`{state}_{direction}_{frame}.png`), so the existing runtime loader picks
  them up with no engine changes.
- `monster_pipeline` — 6-lane atlas + auto-emitted Godot `SpriteFrames`.
- `portrait_pipeline` — emotion-tagged portrait sheet per speaker.
- `biome_pipeline` — environment kit (ground / wall / cliff / water / prop).

## Style anchoring

The four SVG masters in `pictures_artworks/` are the canonical character style
anchors (see `data/pipelines/style/randi_anchor.yaml`). All character generation
is style-locked against them. Monster styling adapts the SoM '93 bestiary into
chapter-coded palettes — each monster manifest declares its own biome anchor,
not the hero anchor.

## Setup

1. Venv (one-time): `python -m venv tools/ludo/.venv` then
   `tools/ludo/.venv/Scripts/python.exe -m pip install -r tools/ludo/requirements.txt`.
2. Key management: the Ludo API key is read from `.mcp.json` (gitignored). No
   second copy needed. If you ever want to override, drop it into
   `tools/ludo/.env` (`LUDO_API_KEY=...`) — that file is gitignored too.

## CLI

```
# Inspect a manifest's call plan, no files written
python -m tools.ludo.cli dry-character data/pipelines/characters/primm.yaml
python -m tools.ludo.cli dry-monster   data/pipelines/monsters/forbidden_falls/rabite.yaml
python -m tools.ludo.cli dry-portrait  data/pipelines/portraits/ch01_cast.yaml
python -m tools.ludo.cli dry-biome     data/pipelines/biomes/forbidden_falls.yaml

# Emit a plan to data/pipelines/_manifest/runs/
python -m tools.ludo.cli plan-character data/pipelines/characters/primm.yaml
python -m tools.ludo.cli plan-monster   data/pipelines/monsters/forbidden_falls/rabite.yaml
python -m tools.ludo.cli plan-portrait  data/pipelines/portraits/ch01_cast.yaml
python -m tools.ludo.cli plan-biome     data/pipelines/biomes/forbidden_falls.yaml

# Show all pending plans + whether they have results yet
python -m tools.ludo.cli list-plans

# After Claude has written {plan_id}.results.yaml:
python -m tools.ludo.cli ingest \
    data/pipelines/_manifest/runs/character-primm-XXXXXXXX.plan.yaml \
    data/pipelines/_manifest/runs/character-primm-XXXXXXXX.results.yaml
```

## Plan format

Each plan step has an `intent` that tells the executor which MCP sequence to run:

| intent              | MCP sequence                                                                                              | output shape                  |
|---------------------|-----------------------------------------------------------------------------------------------------------|-------------------------------|
| `animation_lane`    | `generateWithStyle` → `removeBackground` → `generatePose` → `animateSprite`                              | N frame URLs (`frame_urls`)   |
| `portrait_emotion`  | `createImage` → `removeBackground`                                                                        | one image URL (`image_url`)   |
| `biome_kind`        | `generateWithStyle`                                                                                       | one image URL (`image_url`)   |

## Results format (what Claude writes)

```yaml
plan_id: character-primm-abc12345
results:
  - step_id: idle_down
    status: completed
    job_ids: [j1, j2, j3, j4]
    frame_urls:
      - https://cdn.ludo.ai/.../idle_down_0.png
      - https://cdn.ludo.ai/.../idle_down_1.png
  - step_id: walk_side
    status: completed
    ...
```

## Cache and audit

- `tools/ludo/.cache/{pipeline}/{id}/{cache_key}.json` — content-hashed cache
  of every step's job ids and downloaded files. Re-running a plan with no
  manifest changes is a no-op.
- `data/pipelines/_manifest/manifest.yaml` (committed) — audit ledger of every
  generated file with provenance: pipeline, source manifest, prompt hash,
  style anchor, MCP job id, timestamp.
- `data/pipelines/_manifest/runs/` (gitignored) — transient plans + results.

## Output locations

- Character frames → `game/art/ch{NN}/characters/{id}/{state}_{direction}_{frame}.png`
- Monster atlas   → `game/art/monsters/{biome}/{id}/` + `{id}.tres`
- Portraits       → `game/art/portraits/{faction}/{id}_{emotion}.png`
- Biome kits      → `game/art/environments/{region}/`
