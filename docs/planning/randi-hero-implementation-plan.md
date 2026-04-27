# Randi Hero Implementation Plan

## Purpose

Define how Randi moves from a `sandbox placeholder sprite` to a `playable hero-quality animated character` inside the current 2D Mana-lineage ARPG prototype.

This plan assumes:

- the attached older elf-like sheet is a valid quality and silhouette reference
- the current placeholder sprite lane is not the final hero lane
- Chapter 1 remains the baseline proving ground
- the `Chapter 1 Character Sandbox` is the first implementation target

## Core Reality

The current `32x32 single-frame placeholder` system is useful for:

- silhouette checks
- palette checks
- actor spacing
- interaction readability

It is not enough for:

- hero-quality locomotion
- run cycles
- sword swings with readable commitment
- jumping
- polished action-RPG feel

If we want the project to approach the quality of the older sheet, Randi must move onto a separate `hero-spec` pipeline.

## Locked Decisions

- keep `4-direction + side flip`
- keep ears as a `subtle accent`
- use `double tap in one direction` for run
- treat jump as `combat-usable immediately` once the jump layer is built

## Recommended Hero Spec

### Sprite Standard

- use a `64x64` frame canvas for Randi's hero atlas
- keep the visible body mass closer to `30-38 px` tall inside that frame
- keep consistent grounded foot anchors across all clips
- reserve empty space for:
  - sword extension
  - hood and cape motion
  - jump apex and landing compression

Reason:

- `32x32` is fine for placeholders and some NPCs
- it is too cramped for the sheet quality we are trying to approach
- `64x64` gives room for readable attack arcs and jump states without constantly changing sprite offsets

### Direction Set Options

Option A: `4-direction + side flip`

- down
- up
- side

Pros:

- fastest path to a playable hero
- lowest art cost
- fits the current cardinal-facing combat logic well

Cons:

- less expressive diagonals

Recommendation: locked for the first implementation pass

Option B: `6-direction compromise`

- down
- down-side
- side
- up-side
- up

Pros:

- better travel read
- stronger premium feel

Cons:

- more art and logic complexity

Option C: `8-direction full sheet`

Pros:

- highest fidelity

Cons:

- much slower
- not the right first implementation step for Chapter 1

## Required Gameplay Systems

To make Randi feel like an ARPG hero, we need more than better art.

### 1. Player Motor Split

Split the current player into:

- `PlayerMotor`
  - movement
  - collision
  - attack timing
  - jump rules
  - hurt and recovery states
- `PlayerVisual`
  - sprite playback
  - facing visuals
  - slash effect hooks
  - jump height offset and squash

This prevents animation work from being tangled inside low-level movement code.

### 2. Animation State Machine

Minimum hero states:

- `idle`
- `walk`
- `run`
- `attack_windup`
- `attack_active`
- `attack_recovery`
- `jump_start`
- `jump_air`
- `jump_land`
- `hit`
- `interact`

The current project does not yet have this state layer.

### 3. Attack Timing Events

The sword cannot just be a flashing triangle forever.

Needed:

- hitbox enable frame
- hitbox disable frame
- slash VFX timing
- movement slow or lock during commitment
- recovery window

This is how the animation starts to read as action combat instead of a debug swing.

### 4. Jump Model

The project terminology already commits to `jump-capable traversal`.

Minimum jump support:

- jump input
- takeoff lock
- airborne flag
- landing state
- shadow stays grounded
- sprite receives a vertical visual offset
- optional collision rule for traversable gaps or low obstacles later

Without this, the game is still missing one of its stated core verbs.

### 5. Hero Atlas Import Rules

We need a formal atlas contract for Randi:

- naming per clip
- frame order
- frame durations
- pivot and feet anchor
- sword-hand consistency
- side-flip rules
- hurt and jump frame reuse rules

## Minimum Animation Deliverables

These are the first clips worth making.

### Locomotion

- `idle_down`
- `idle_up`
- `idle_side`
- `walk_down`
- `walk_up`
- `walk_side`
- `run_down`
- `run_up`
- `run_side`

### Combat

- `attack_down`
- `attack_up`
- `attack_side`
- `slash_fx_down`
- `slash_fx_up`
- `slash_fx_side`

### Jump

- `jump_start_down`
- `jump_air_down`
- `jump_land_down`
- same for `up` and `side` if possible

### Reaction

- `hit_down`
- `hit_up`
- `hit_side`

## Low-Level Runtime Tasks

### Phase 1: Hero Visual Infrastructure

- refactor `player.tscn` to include a visual root
- add `AnimatedSprite2D` or equivalent sprite playback node
- preserve the existing collision body and attack area
- allow fallback between polygon body and sprite body during transition
- keep prompt and interaction behavior unchanged

### Phase 2: Locomotion Animation

- add double-tap detection for one-direction running
- add speed tiers for walk and run
- drive animation state from movement magnitude and facing
- keep side animation flippable if we use the 4-direction plan
- add a grounded shadow that stays stable as the sprite animates

### Phase 3: Sword Swoop

- replace the current attack presentation with a clip-driven swing
- keep the hit logic in the motor, not in the sprite file
- add one slash VFX layer
- tune startup, active, and recovery
- verify enemy knockback still feels readable

### Phase 4: Jump

- add `jump` action and state
- add jump arc timer and air-state lock
- drive sprite vertical offset visually
- scale or darken the shadow to sell height
- allow jump to become combat-usable immediately:
  - keep the first version small in scope
  - but do not wall it off as traversal-only

### Phase 5: Sandbox Integration

- use the `Chapter 1 Character Sandbox` as the only testbed first
- compare hero scale against:
  - villager
  - attendant
  - refugee
  - rabite
- tune footprint before rolling into Chapter 1 scenes

## Art Production Tasks For Randi

### Immediate

- lock the hero-spec frame canvas
- lock Randi's direction set
- lock whether the ears stay subtle or become explicit species coding
- build one neutral turnaround sheet
- build one locomotion sheet
- build one attack sheet
- build one jump sheet

### After First Runtime Hookup

- tune hood silhouette during movement
- tune hair brightness against the Chapter 1 palette
- ensure sword silhouette remains readable over dark floors
- reduce costume noise if the hero stops reading at gameplay distance

## Recommended Implementation Order

1. Hero spec for Randi is locked:
   - `64x64`
   - `4-direction + side flip`
   - subtle ears only for now
2. Refactor the player scene into `motor + visual`.
3. Hook in `idle / walk / run` first.
4. Hook in `attack_windup / active / recovery` with a real sword swing.
5. Add `jump_start / air / land` as a combat-usable verb.
6. Only then start polishing Chapter 1 scene integration.

## Key Decision Questions

These must be answered before full production starts:

## Current Implementation Recommendation

For the current project state, the sensible first implementation is:

- `64x64` hero atlas
- `4-direction + side flip`
- `run` via double tap in one direction
- `jump` combat-usable once implemented
- keep the older sheet as quality target and silhouette reference, not as a literal final atlas
