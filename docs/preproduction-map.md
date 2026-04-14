# Secret of Mana Revisited: Preproduction Map

## Purpose

This is the authoritative map of the pre-programming package. It points to the current source-of-truth documents and defines the order in which they should be used.

## Current Source Of Truth

- `story structure`: `docs/story-modules.md`
- `factions and power map`: `docs/faction-bible.md`
- `engine and pipeline direction`: `docs/development-framework.md`
- `visual language`: `docs/art-direction-brief.md`
- `content conventions and IDs`: `docs/content-conventions.md`
- `content templates`: `docs/templates/content-templates.md`
- `chapter 1 package`: `docs/chapters/chapter-01-falls-to-pandora.md`
- `Pandora character sheets`: `docs/characters/pandora-character-sheets.md`
- `Empire character sheets`: `docs/characters/empire-character-sheets.md`
- `tracker and open items`: `docs/planning/task-tracker.md`, `docs/planning/open-items.md`
- `Godot bootstrap rules`: `docs/godot-bootstrap.md`

## Canonical Decisions Locked So Far

- Engine: `Godot 4.4+`
- Art style: dense, ornate, top-down pixel fantasy with no remake-style 3D presentation
- Tone: melancholic mythic adventure with political weight
- Chapter 1 boundary: `Potos -> exile -> wilderness transition -> Water Palace approach -> Pandora arrival and first political contact`
- Narrative source of truth remains Markdown during preproduction
- Structured content should later mirror into JSON or YAML after templates stabilize
- Godot scaffolding is part of pre-programming setup, but gameplay code is still out of scope

## Canonical Terminology

- `Mana`: the world-binding force that functions as ecology, memory, authority, and magical energy
- `Temple Orders`: regional custodians of mana practice, not branches of one unified church
- `Gemma Tradition`: the inherited sword-and-seal guardianship structure represented by Jema and earlier keepers
- `Imperial Blocs`: the internal power groupings inside the Empire of Vandole
- `Corruption`: mana destabilization manifesting in living regions, bodies, and spirits
- `Necromancy`: deliberate Thanatos-linked manipulation of death, possession, and grief
- `Engineered Mana Abuse`: artificial or imperial extraction, rerouting, or weaponization of mana systems

## Working Order

1. Use `story-modules` and `faction-bible` to shape narrative decisions.
2. Use `character sheets` when writing scenes or quest logic.
3. Use `content conventions` and `templates` before drafting new content docs.
4. Use the `chapter 1 package` as the production benchmark for later chapters.
5. Use `godot-bootstrap` when creating the project shell and mirrored data folders.

## Minimum Definition Of "Ready To Start Programming"

The project is ready to begin systems implementation when:

- Chapter 1 scenes and quests are stable enough to build without narrative reinterpretation
- faction leaders and recurring officers are named and placed in story flow
- art requirements for the first benchmark area are defined
- IDs, flags, and content templates are locked
- the Godot folder scaffold and bootstrap rules are in place
- remaining open items are small enough that they do not block controller, dialogue, quest, and map framework work
