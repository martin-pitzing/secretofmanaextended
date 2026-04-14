# Early Progression Locks

## Purpose

This document closes the remaining early-game design decisions that were still open before the first Godot shell.

It locks:

- early reward variance
- Pandora conservative / imperial contact visibility

## Reward Variance Rule

### Locked Direction

Chapters `1-2` remain primarily narrative-reward driven, with only **light equipment variance** introduced through optional content and civic-route side objectives.

### What This Means

- mainline quests reward:
  - party unlocks
  - region access
  - faction trust changes
  - story flags
  - route knowledge
- optional side content may reward:
  - minor utility equipment
  - region-flavored consumables
  - route shortcuts
  - trust modifiers
- no major stat-build branching should appear before Chapter `3`

### Reason

- the early game is teaching tone, stakes, and party identity first
- heavy gear variance this early would distract from exile, Pandora pressure, and the first temple cycle
- light variance still gives optional play tangible payoff without forcing early balance complexity

## Locked Early Reward Categories

### Chapter 1 Optional Reward Profile

- one `river-ward charm` style item
- one minor recovery or travel utility bundle
- one later trust acknowledgment from Luka or a Pandora contact

### Chapter 2 Optional Reward Profile

- one `relief satchel` or field-utility item
- one `court runner` or route-access item
- one reform-contact trust bonus

### Chapter 3 Onward

- broader equipment sidegrades may start once:
  - all three protagonists are active
  - Watts and forging are established
  - regional economies are more legible

## Pandora Conservative / Imperial Contact Rule

### Locked Direction

In Chapters `1-2`, conservative Pandora contact with imperial intermediaries remains **indirect, deniable, and document-driven**.

### Show It Through

- altered ration approvals
- sealed courier routes
- privileged access notices
- servants, legal clerks, or merchant proxies
- Kroll arriving to a situation that was quietly prepared for him
- ledger fragments proving accommodation pressure without full public conspiracy

### Do Not Show Yet

- Voss or another conservative openly pledging submission on-screen
- direct formal conspiracy scenes between Pandora conservatives and Kroll in early chapters
- explicit public collaboration before Pandora's later breakdown phases

### Reason

- early Pandora works better when the court is still trying to preserve deniability
- open collaboration too early would flatten the internal political split into obvious villain signaling
- indirect contact preserves tension and lets later exposure hit harder

## Chapter-Level Implications

### Chapter 1

- imperial influence is rumor, decrees, supply disruption, and symbolic pressure only

### Chapter 2

- Kroll's arrival should feel preconditioned by conservative backchannels
- the player should infer collusion through paperwork, access, and timing
- the court split stays believable because deniability still matters

## Structured Reward Examples

Use these as the first implementation-facing examples:

- `q_ch01_101_river_warning_ledger`: narrative acknowledgment plus a minor `river-ward charm`
- `q_ch02_101_relief_crate_diversion`: reform-contact trust bonus plus a small `relief satchel`
- `q_ch02_102_service_passage_map`: route shortcut plus a light `court runner sash` utility reward

### Later State-Collapse Chapters

- open coordination may finally become visible once conservative actors decide survival is worth losing plausible innocence

## Production Consequence

These locks mean the project no longer needs additional design debate before:

- the first quest reward tables are mocked up
- Chapter 1-2 scenes are ported into a first dialogue/quest tool layer
- the Godot shell is created with stable early content assumptions
