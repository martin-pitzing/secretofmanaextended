# Secret of Mana Revisited: Godot Bootstrap Rules

## Purpose

This document defines the first project shell to create before gameplay code begins.

## Engine Target

- `Godot 4.4+`
- 2D-first project
- GDScript as the default scripting language
- C# only if a later system clearly needs it

## Project Naming

- working repo name: `secretofmana-extended`
- Godot project display name: `Secret of Mana Revisited`
- internal content prefix should use `somr` only if a short namespace is later needed for tools or exports

## Rendering Constraints

- target internal prototype resolution: `480x270`
- prefer integer scale presentation whenever possible
- lock pixel snapping and camera rules before broad content implementation
- avoid post-processing that blurs authored sprites or mimics 3D remake gloss

## Folder Contract

The initial scaffold should exist as empty directories with README placeholders and no gameplay logic:

```text
game/
  scenes/
  scripts/
  systems/
  data/
    chapters/
    quests/
    characters/
    factions/
    regions/
    flags/
  art/
  audio/
  ui/
```

## What Belongs Where

- `game/scenes/`: future Godot scene files and scene-local helpers
- `game/scripts/`: lightweight behavior scripts and utility logic
- `game/systems/`: larger gameplay frameworks such as combat, dialogue, quest, and save systems
- `game/data/`: mirrored structured content exported from or aligned with the design docs
- `game/art/`: imported production assets and benchmark assets
- `game/audio/`: music, SFX, and future middleware exports if used
- `game/ui/`: menus, portraits, HUD, and dialogue presentation assets

## Pre-Coding Deliverables Expected Before Bootstrap

- Chapter 1 package is stable
- content templates and ID rules are stable
- first benchmark room requirements are defined
- character and faction naming is stable enough to avoid immediate rework

## Explicit Out Of Scope

- no `project.godot` yet
- no gameplay scripts yet
- no data serialization files yet
- no art imports yet

This scaffold is meant to keep the repo organized while narrative, art, and content specification finalize.
