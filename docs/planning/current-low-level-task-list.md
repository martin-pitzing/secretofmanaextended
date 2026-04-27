# Secret of Mana Revisited: Current Low-Level Task List

## Purpose

Convert the current repo state into concrete low-level production tasks that can be executed without reopening major direction questions.

This list assumes the currently locked direction:

- polished `2D Mana-lineage action RPG`
- Chapter 1 as the shared baseline
- modular chapter runtime with Chapter 1 and Chapter 2 currently wired
- Chapter 1 character sandbox available as the main actor-and-sprite proving ground

## Current Runtime And Kernel Tasks

### Done Infrastructure That Now Needs Follow-Through

- keep `chapter_content_repository.gd` on dynamic chapter discovery and stop adding new hard-coded content folders
- keep chapter-owned story routing inside module scripts instead of backsliding into `prototype_main.gd`
- preserve the three build profiles:
  - `dev_all_content`
  - `review_slice_ch01`
  - `review_slice_ch01_ch02`
- keep Chapter 1 and Chapter 2 validators green while new content and art hooks land

### Low-Level Runtime Tasks

- add a visible build-profile readout somewhere in the runtime UI
- add a review-safe dev toggle entry path instead of relying only on command-line `--dev-tools`
- move more scene-specific interaction points from invisible triggers to visible actors where the scene benefits from character presence
- add portrait-ready metadata to visible interaction actors:
  - portrait ID
  - faction/role tag
  - optional sprite facing hint
- add player placeholder sprite support on top of the current polygon player
- add enemy placeholder sprite support on top of the current practice enemy
- add one limited ring-command stub lane into the sandbox or Chapter 1 baseline
- add one character-state test path for:
  - idle
  - attack
  - hit
  - talk
- add one simple actor color-state hook to show ally, civilian, and hostile reads cleanly
- promote `Randi` from `placeholder sprite` to `hero atlas`
- use `64x64` frames for the Randi hero atlas, not `32x32`
- keep the visible hero body mass around `30-38 px` tall inside the frame so sword, hood, and jump space fit cleanly
- split the player into `motor + visual`
- keep `PlayerMotor` responsible for:
  - movement
  - collision
  - attack timing
  - jump
  - hurt
- keep `PlayerVisual` responsible for:
  - sprite playback
  - facing
  - sword VFX
  - jump height offset
- add a real player animation state machine with at least:
  - idle
  - walk
  - run
  - attack_windup
  - attack_active
  - attack_recovery
  - jump_start
  - jump_air
  - jump_land
  - hit
  - interact
- replace the current slash-triangle attack presentation with clip-driven sword timing later:
  - hitbox enable and disable
  - startup
  - active
  - recovery
  - slash FX
- add jump as a real verb later with:
  - input
  - air state
  - landing
  - grounded shadow
  - sprite Y-offset

## Current Chapter 1 Character Sandbox Tasks

### Immediate Sprite Tasks

- review the current first-pass placeholder sprite for `Randi`
- review the current first-pass placeholder sprite for `Potos Villager`
- review the current first-pass placeholder sprite for `Water Palace Attendant`
- review the current first-pass placeholder sprite for `Pandora Refugee`
- review the current first-pass placeholder sprite for `Rabite Echo`
- review all five in the `Chapter 1 Character Sandbox`
- tune actor placement if sprite footprints read too small or too large
- tune palette contrast if any actor blends into its pod background
- decide whether the sandbox defaults should stay at one-frame south-facing placeholders or move to two-frame idle loops next
- decide whether the generator should keep producing only `sandbox_placeholder.png` or also emit simple `idle_a` and `idle_b` next
- build the first `Randi hero atlas` in the sandbox before rolling it into chapter scenes
- keep all hero animation testing inside the `Chapter 1 Character Sandbox` first

### Immediate Sandbox Review Tasks

- confirm visible actors read cleanly at gameplay distance
- confirm `E / Enter` prompt spacing feels correct for each actor
- confirm the combat pod still reads after sprite placeholders replace polygon stands
- confirm the cute-monster placeholder stays readable as an enemy rather than a plush prop
- confirm the current player polygon still scales reasonably against the new placeholder sprite sizes

## Current Chapter 1 Visual Tasks

### Character-Facing Tasks

- lock a placeholder sprite canvas rule for Chapter 1 humans
- lock a placeholder sprite canvas rule for small Chapter 1 monsters
- preserve `pictures_artworks/` as source artwork input, not direct runtime atlas output
- keep source page resolution separate from logical atlas cell resolution
- use the new `source_pages` ingest pipeline before replacing any more generated hero frames
- keep the first `Randi pose crop + atlas slot manifest` as the source-to-runtime transfer contract
- keep `hero64_tall` as the primary Randi runtime authoring lane
- use `native32_tall` only as a strict comparison and compression check
- review crop rectangles in the preview atlas before repainting any final hero frames
- lock `64x64` as the first Randi hero-spec atlas canvas
- keep `4-direction + side flip` as the first Randi direction set
- keep the pointed-ear read as a `subtle accent`, not a full species lock
- implement running via `double tap in one direction`
- plan jump as `combat-usable immediately` once the jump layer is built
- define first-pass palette ranges for:
  - Potos villagers
  - Water Palace staff
  - Pandora civilians
  - Chapter 1 destabilized monsters
- define one reuse rule for travel wear and damage wear so every new sprite does not invent a new finish language
- build the first real Randi hero deliverables as:
  - idle_down, idle_up, idle_side
  - walk_down, walk_up, walk_side
  - run_down, run_up, run_side
  - attack_down, attack_up, attack_side
  - jump_start, jump_air, jump_land
  - hit_down, hit_up, hit_side

### Environment-Facing Tasks

- start the `Water Palace` visual baseline pass first
- start the `Forbidden Falls` visual baseline pass second
- start the `Potos` visual baseline pass third
- drop first placeholder stills into the five `game/art/ch01/review_stills/` folders
- replace the strongest still-backed stage with more spatial dressing once the palette and prop rules hold

## Current Story-Safe Content Tasks

- add explicit dependency declarations to Chapter 1 and Chapter 2 scene and quest mirrors
- define a lightweight semantic-shift note format for ID meaning changes
- make Chapter 1 -> Chapter 2 handoff assumptions visible in docs, not only validators
- avoid turning Chapters 3-12 YAML presence into runtime presence until chapter modules exist for them

## Current Review And Packaging Tasks

- document the new build-profile launch commands in one place
- document how to enter the Chapter 1 character sandbox from a dev-enabled build
- package a reviewable Chapter 1-only slice with no hidden control surprises
- package a reviewable Chapter 1-2 slice with clean launch instructions

## Recommended Immediate Order

1. Refactor the player scene into `motor + visual` while preserving current collision, prompt, and hit logic.
2. Add a sprite visual root with polygon fallback and hook up `idle / walk / run` in the `Chapter 1 Character Sandbox`.
3. Promote Randi from placeholder sprite to first `64x64` hero atlas and test only in the sandbox first.
4. Replace the current attack presentation with clip-driven sword timing.
5. Add jump as a real, combat-usable verb.
6. Transfer the imported `pictures_artworks` source pages into cleaned `hero64_tall` runtime atlas frames instead of extending the procedural hero placeholder generator.
