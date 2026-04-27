# Secret of Mana Revisited: 2D Action RPG Terminology

## Purpose

Lock the language used to describe the target game so art, systems, chapter docs, and prototype benchmarks stop drifting between `top-down adventure prototype`, `pixel remake`, and `action RPG`.

## Target Statement

This project is a `2D action RPG` in the `Mana-lineage` with:

- live combat on the map
- semi-overhead or diagonal-down field presentation
- jump-capable traversal
- party-forward exploration
- ring-command style ability selection
- readable combat verbs
- hand-authored pixel presentation

## Reference Lane

Use this reference stack together instead of collapsing the target into one comparison:

- `Secret of Mana`: party rhythm, ring-command identity, sacred-world tone, live combat in explorable spaces
- `Alundra`: jump-capable traversal, room-scale puzzle and action structure, real-time weapon and item use
- `Terranigma`: movement verbs built from run, attack, and jump, brisk field combat, ring-like magic utility items

The correct short description is not `Zelda-like` or `just Secret of Mana but polished`.

The correct short description is:

- `polished 2D Mana-lineage action RPG`
- or `2D action RPG with jump-capable traversal in the Alundra / Terranigma lane`

## Canonical Gameplay Terms

Use these terms consistently across design, art, and implementation docs.

- `2D action RPG`: the primary genre label
- `Mana-lineage action RPG`: use when describing the project's overall identity
- `semi-overhead field view`: the default exploration and combat camera lane; use this instead of the vaguer `top-down` when height reads and jumping matter
- `map-native combat`: combat happens in the live map, not in a separate battle scene
- `jump-capable traversal`: jumping is a real navigation and combat-support verb, not a cinematic one-off
- `hero locomotion`: how the playable character starts, accelerates, lands, turns, and recovers
- `combat lane`: the readable strip or pocket of space where player movement, enemy pressure, and hazards interact
- `attack commitment`: visible startup, active, and recovery time on attacks
- `enemy anticipation`: the readable tell before an enemy strike
- `enemy recovery`: the punish window after an enemy action
- `damage feedback`: hit flash, recoil, sound, pause, knockback, and VFX that confirm contact
- `ability selection flow`: how the player reaches spells, items, and support actions without losing combat readability
- `ring-command layer`: the radial or fast-pause selection layer for magic, items, and party functions
- `party-state visibility`: the player can read who is present, threatened, down, casting, or ready to act
- `combat benchmark room`: a reference room whose job is to prove movement, enemy read, hit feedback, and spatial combat clarity
- `social zone`: low-threat town, court, or temple approach space focused on talk, route gating, and state read
- `traversal route`: movement-first space linking social and combat beats
- `ritual approach`: low-threat sacred space that leads into a ritual chamber and establishes access, authority, and route logic
- `ritual chamber`: sacred interaction room where authority read, staging, and spell or lore presentation matter more than enemy density
- `civic stage`: public or formal space where the main gameplay value is reading power performance, crowd reaction, or overheard authority conflict
- `pursuit lane`: a route where pressure comes from chase, timing, and path read rather than sustained brawling
- `infiltration route`: a route where avoidance, timing, and objective clarity matter more than enemy count
- `story stage`: acceptable prototype term for an unfinished scene shell; not a shipping-facing genre label

## Terms To Avoid Or Use Carefully

- `top-down`, unless the map is truly flat and overhead with no meaningful jump or height read
- `adventure prototype`, when the scene is really meant to prove combat language
- `benchmark geometry`, except as internal shorthand during blockout
- `Zelda-like`, because it hides the Mana, Alundra, and Terranigma blend that actually defines the target
- `pixel diorama`, except as a style phrase; it should not replace the main gameplay identity

## What Must Read As Action RPG

These are not optional polish notes. They are the baseline for whether the game reads as an action RPG at all.

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

If these do not read clearly, the game may still be attractive, but it will read as an exploration prototype rather than an action RPG.

## Scene-Type Vocabulary For Chapter Docs

When chapter docs describe player control states and room purpose, prefer these labels:

- `social zone`
- `traversal route`
- `ritual approach`
- `combat benchmark room`
- `ritual chamber`
- `civic stage`
- `pursuit lane`
- `infiltration route`

This helps scene writing, map blockout, and combat planning speak about the same thing.

## Implementation Consequence

This terminology changes how the project should be judged:

- art docs must talk about locomotion silhouette, attack arcs, and enemy telegraphs
- systems docs must talk about jump-capable traversal, attack commitment, and ring-command flow
- chapter docs must classify scenes by gameplay role, not only by narrative beat
- benchmark rooms must prove combat readability, not only composition and atmosphere
