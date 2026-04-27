# Secret of Mana Revisited: Agent Guide

## Purpose

This file locks the project rules that future agents should follow before changing story, runtime, chapter modules, visuals, or review builds.

Use this guide together with:

- `docs/preproduction-map.md`
- `docs/action-rpg-terminology.md`
- `docs/planning/godot-modular-build-and-story-plan.md`
- `docs/content-conventions.md`

## Project Identity

- This project is a `polished 2D Mana-lineage action RPG`.
- The reference lane is `Secret of Mana` + `Alundra` + `Terranigma`.
- The game must read as a live-map action RPG with `jump-capable traversal`, `map-native combat`, and a `ring-command layer`.
- Do not drift into `3D remake`, `toy-like chibi 3D`, `generic Zelda-like`, or `adventure prototype` language when the work is really about action-RPG readability.

## Canonical Source Order

When there is ambiguity, use this order:

1. `docs/preproduction-map.md`
2. `docs/action-rpg-terminology.md`
3. `docs/planning/godot-modular-build-and-story-plan.md`
4. `docs/content-conventions.md`
5. relevant `docs/chapters/*.md`
6. relevant `game/data/scenes/<chapter>/` and `game/data/quests/<chapter>/` mirrors

If a runtime or YAML mirror disagrees with the editorial docs, treat the Markdown docs as authoritative and bring the mirrors back into alignment.

## Locked Production Defaults

- chapter packaging is `one module per chapter`
- Markdown remains the editorial source of truth, with YAML as the runtime mirror
- build targets are `dev_all_content`, `review_slice_ch01`, and `review_slice_ch01_ch02`
- story safety requires `validators + explicit dependency declarations`
- later chapters may override `configuration and content`, not shared system behavior, unless a real system gap is proved
- Chapter 1 is the kernel baseline before more Chapter 2-specific system polish
- Chapter 1 gets a `limited ring-command stub` before a full ring-command implementation
- visual work should start with a `reusable chapter visual profile`, then scene overrides
- preserve IDs whenever possible; semantic shifts require declarations and downstream review
- side objectives stay chapter-owned for now
- review builds keep debug access behind a `dev toggle`
- packaged builds stay `editor + wrapper only` until after the loader refactor
- Chapter 1 visual production priority is `Water Palace`, then `Forbidden Falls`, then `Potos`
- placeholder stills remain part of the modular chapter pipeline
- Chapter 1 -> Chapter 2 handoff validation is mandatory before Chapter 3 becomes runtime content

## Story And Content Rules

- Keep story work chapter-bounded unless the user explicitly asks for cross-chapter restructuring.
- Use the canonical scene-role vocabulary from `docs/action-rpg-terminology.md` in chapter docs and gameplay planning.
- Preserve stable IDs for chapters, scenes, quests, flags, regions, factions, and characters.
- If semantics change:
  - keep the ID when prose or flavor changes but the gameplay contract stays the same
  - create a new ID when player goal, exit condition, required flags, or exported meaning changes
  - add a short semantic-shift declaration in the relevant planning or migration note
- Later chapters may consume exported flags from earlier chapters, but must not redefine what those flags mean.
- When touching scene or quest flow, update the Markdown source and the YAML mirrors in the same change or note the mismatch explicitly.
- Handoff logic between chapters should be validated, not assumed.

## Runtime And Build Rules

- Keep the `game kernel` separate from chapter-owned routing and chapter presentation logic.
- Prefer data-driven or configuration-driven chapter behavior over hard-coded scene routing in shared runtime scripts.
- Build profile work should support:
  - `dev_all_content`
  - `review_slice_ch01`
  - `review_slice_ch01_ch02`
- Review builds should hide debug affordances by default and only expose them through an explicit dev toggle.
- Do not let Chapter 3+ runtime work proceed without Chapter 1 validation and Chapter 1 -> 2 handoff checks in place.

## Visual And Texture Rules

- The art lane is `ornate pixel fantasy with clear action-RPG readability`.
- Always protect these reads:
  - readable hero locomotion
  - committed attack animations
  - enemy anticipation and recovery
  - spatial combat lanes
  - damage feedback
  - camera support for combat
  - ability selection flow
  - party-state visibility
  - strong enemy silhouettes
  - clear interaction between melee, magic, and movement
- Add detail through `material storytelling`, `ritual wear`, and `social use`, not random clutter.
- Avoid:
  - remake-style gloss
  - HD-2D bloom overload
  - toy-like 3D anime reads
  - generic medieval clutter
- Reusable chapter visual profiles come before scene-specific art exceptions.
- Placeholder still boards should stay in the runtime pipeline instead of becoming separate presentation tools.

## Chapter 1 Baseline Rules

- Chapter 1 is the baseline for combat feel, ring-command stub behavior, jump-capable traversal rules, visual profile rules, and validator pattern.
- The Chapter 1 visual anchor order is:
  1. `Water Palace`
  2. `Forbidden Falls`
  3. `Potos`
- Chapter 2 remains the next integration and review target, not the place where first-pass shared systems are invented.

## How To Handle Vague Requests

Ask questions when ambiguity would change:

- architecture ownership
- stable IDs or exported flags
- chapter boundaries
- handoff assumptions
- the art lane
- texture/material direction
- benchmark priority

When asking, present `2-3 options` and recommend one. Keep questions concrete and tied to production tradeoffs.

## Project Skills

Repo-owned project skills live under:

- `.agents/skills/somr-chapter-module-authoring/`
- `.agents/skills/somr-visual-style-authoring/`

Use them when work is primarily:

- chapter-safe content and validator authoring
- visual-style, texture, palette, prop-kit, or placeholder-stage authoring
