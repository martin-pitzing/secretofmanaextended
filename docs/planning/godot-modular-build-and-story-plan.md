# Secret of Mana Revisited: Godot Modular Build And Story Plan

## Purpose

Define how the Godot project should evolve from the current Chapters 1-2 prototype into a modular full-game structure that:

- supports chapter-by-chapter visual and gameplay upgrades
- keeps the base action-RPG framework stable while content grows
- allows internal slice builds without rewriting the whole project
- protects later chapters from breaking when story changes are made upstream

This plan is intentionally architecture-first.

It is not the implementation itself.

## Locked Decisions

The following defaults are now accepted and should be treated as project policy:

- chapter packaging is `one module per chapter`
- Markdown remains the editorial source of truth, with YAML as the runtime mirror
- build targets are `dev_all_content`, `review_slice_ch01`, and `review_slice_ch01_ch02`
- story safety requires `validators + explicit dependency declarations`
- later chapters may override `configuration and content`, not shared system behavior, unless a real system gap is proved
- Chapter 1 is the baseline for shared combat feel before deeper Chapter 2-specific polish
- Chapter 1 gets a `limited ring-command stub` before the full system
- visual authoring should start with a `reusable chapter visual profile`, then scene overrides
- preserve IDs whenever possible; semantic shifts require declarations and downstream review
- side objectives stay chapter-owned for now
- review builds keep debug access behind a `dev toggle`
- packaged builds stay `editor + wrapper only` until after the loader refactor
- Chapter 1 visual production anchor order is `Water Palace`, then `Forbidden Falls`, then `Potos`
- placeholder stills remain part of the modular chapter pipeline
- Chapter 1 -> Chapter 2 handoff validation is mandatory before Chapter 3 becomes runtime content

## What The Current Project Already Does Well

- Chapters 1 and 2 already have stable IDs, scene mirrors, quest mirrors, and chapter manifests under `game/data/`
- the runtime can already load chapter content and move across scene order using flags and quest completion
- the project already has a markdown-first editorial flow with YAML mirrors
- Chapter 2 already has a validation script proving end-to-end route sanity

These are the correct seeds for a modular game.

## Current Structural Gaps

The project is not yet modular enough for full production.

Current limits:

- the content repository only loads a narrow hard-coded chapter set
- the runtime map-routing logic is still hand-authored per scene in one script
- chapter visuals are not yet organized as reusable chapter modules with shared profiles
- story changes do not yet run through compatibility checks or dependency validation
- there is no chapter-safe migration layer for flags, quests, or reordered scenes
- there are no build profiles for `chapter slice`, `review slice`, and `full campaign`

## Architectural Goal

Build the game in two layers:

### Layer 1: Core Game Kernel

This should contain only reusable game systems:

- player controller
- combat framework
- ring-command layer
- dialogue framework
- quest/state framework
- save/load
- chapter loading
- chapter validation
- reusable map and scene helpers
- base UI/HUD

This layer must not contain Chapter 1-specific assumptions once the refactor is complete.

### Layer 2: Chapter Content Modules

Each chapter should become a content module that plugs into the kernel:

- chapter manifest
- scene manifests
- quest manifests
- chapter map routing
- chapter art profiles
- chapter encounter definitions
- chapter dialogue and progression hooks
- chapter validators

This is the layer where visual work can be deepened chapter by chapter without destabilizing the kernel.

## Recommended Folder Direction

Recommended target structure:

```text
game/
  systems/
    core/
    combat/
    narrative/
    save/
    ui/
    validation/
  content/
    chapters/
      ch01/
        chapter_manifest.tres or .gd/.yaml bridge
        scenes/
        quests/
        maps/
        encounters/
        visuals/
        validators/
      ch02/
        ...
  scenes/
    core/
    ui/
    chapters/
      ch01/
      ch02/
  art/
    shared/
    chapters/
      ch01/
      ch02/
  data/
    chapters/
    scenes/
    quests/
    flags/
```

This keeps `systems` reusable and `chapters` swappable.

## Build Strategy

### Recommended Build Modes

The project should support three build targets.

#### 1. `dev_all_content`

Purpose:

- full internal development build
- all currently wired chapters present
- debug tools and validators enabled

Use for:

- day-to-day implementation
- integration testing

#### 2. `review_slice_ch01`

Purpose:

- chapter-1-only review build
- visual, pacing, and combat benchmark iteration

Use for:

- art review
- movement/combat review
- opening-hour pacing review

#### 3. `review_slice_ch01_ch02`

Purpose:

- current vertical slice build
- Chapter 1 to Chapter 2 departure path

Use for:

- internal stakeholders
- creative review
- progression and stability review

Later, a `full_campaign` build can be added once later chapters are real runtime content.

## Recommended Chapter Module Contract

Every chapter module should explicitly own:

- chapter ID
- chapter title
- allowed predecessor chapter IDs
- chapter scene order
- chapter quest order
- chapter local flags
- chapter-exported completion flags
- chapter visual profile IDs
- chapter map routing rules
- chapter validator entrypoint

This means a chapter can be reasoned about as a bounded package.

## Story-Safety Architecture

The project needs a method for changing story content without silently breaking later content.

### 1. Stable IDs Are Law

Once a chapter, scene, quest, flag, region, or character ID is used in runtime content:

- do not rename it casually
- do not change its meaning without a migration note
- do not recycle retired IDs

If intent changes badly enough, create a new ID.

### 2. Chapter Ownership Rules

Each flag should have an owning chapter or owning system.

Example:

- `flag_character_primm_joined_party` is produced in Chapter 2
- later chapters can require it
- later chapters must not redefine what it means

### 3. Dependency Declarations

Each scene and quest should eventually declare:

- required prior flags
- required party state
- blocked flags
- optional flavor flags
- resulting flags

That allows validation to detect impossible or contradictory story states.

### 4. Compatibility Tiers For Story Changes

Every story edit should be classified as:

- `safe text edit`
  prose, line, or flavor change only
- `scene contract edit`
  player goal, participants, or exit condition changed
- `progression edit`
  scene order, quest order, or flags changed
- `breaking narrative edit`
  downstream chapter assumptions must be reviewed

Only the first category should be allowed without follow-up checks.

### 5. Validator Requirements

Each chapter should eventually have validators that check:

- scene IDs exist
- quest IDs exist
- scene order is contiguous
- required flags are produced before they are consumed
- chapter handoff flags match the next chapter's assumptions
- no removed flag is still referenced downstream

### 6. Story Migration Notes

Whenever a breaking progression or flag change happens, add a short migration note:

- old meaning
- new meaning
- affected chapters
- required validator updates
- save compatibility risk

This can live in a future `docs/planning/story-migrations.md`.

## Recommended Refactor Order

### Phase 1. Generalize The Content Loader

Goals:

- remove the hard-coded Chapter 1-2 loading assumption
- load chapters from manifests dynamically
- let the runtime ask for chapter content by ID instead of by manual registration

Output:

- generalized chapter registry
- chapter module discovery

### Phase 2. Separate Core Systems From Prototype Scene Logic

Goals:

- move chapter-independent logic into `game/systems/`
- reduce `prototype_main.gd` from a catch-all controller into an integration shell

Output:

- clearer kernel layer
- less chapter-specific glue inside one runtime file

### Phase 3. Formalize Chapter Routing

Goals:

- replace the monolithic scene-to-map routing table with per-chapter routing data
- support chapter-local map modules and visual upgrades

Output:

- chapter-owned scene routing
- cleaner chapter-specific visual iteration

### Phase 4. Add Story Validators

Goals:

- validate chapter manifests, scene links, quest links, and handoff flags
- catch breakage when story changes happen

Output:

- Chapter 1 validator
- Chapter 1->2 handoff validator
- generalized validation pattern for later chapters

### Phase 5. Add Build Profiles

Goals:

- support chapter slice exports and review builds
- separate `dev`, `review`, and `full` assumptions

Output:

- documented launch/build modes
- build-target config plan

### Phase 6. Use Chapter 1 As The Full Vertical Baseline

Goals:

- finish the baseline gameplay and visual standards in Chapter 1 first
- use Chapter 1 as the reference contract before scaling to later chapters

Output:

- the first real kernel-ready chapter module
- the model all later chapters follow

## Recommended Chapter-1-First Policy

Build Chapter 1 as the full reference for:

- locomotion
- combat baseline
- jump-capable traversal rules
- ring-command stub
- chapter visual profile
- map composition rules
- validator pattern

Chapter 2 should stay the next integration target, not the place where base systems are invented first.

## Decisions Now Locked For Refactor

These items no longer need to be reopened unless a concrete implementation problem appears:

- chapter packaging remains `one module per chapter`
- chapter visual configuration remains `chapter visual profile + scene overrides`
- story safety remains `validators + dependency declarations`
- build-target strategy remains `named review slices plus dev build`
- Chapter 2 should not override shared systems behavior unless a real kernel gap is demonstrated
- side objectives remain owned inside each chapter for now
- preserve IDs whenever possible, with semantic-shift declarations when meaning changes
- Chapter 1 stays the combat-feel baseline
- Chapter 1 owns the first limited ring-command behavior
- review builds keep debug access behind a dev toggle
- placeholder stills remain part of the modular chapter pipeline instead of being treated as Chapter 1-only disposable scaffolding

## Recommended Immediate Next Moves

1. Lock the decision areas above, starting with packaging granularity, runtime source of truth, and story-safety level.
2. Generalize the content repository so it can discover chapter manifests dynamically.
3. Define the chapter module contract in code and data.
4. Build Chapter 1 validator coverage to match or exceed Chapter 2.
5. Start moving chapter routing ownership out of the monolithic runtime shell.

## Success Condition

This plan succeeds when:

- Chapter 1 can be developed as the baseline module without hard-coding its assumptions into the whole game
- Chapter 2 can deepen without forcing rewrites of the base kernel
- later story changes can be classified and validated before they silently break downstream content
- internal builds can target a single chapter, a vertical slice, or the full campaign path without repo surgery
