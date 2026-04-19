# Secret of Mana Revisited: Next Steps Roadmap

## Goal

Move from broad preproduction into a tighter narrative production sequence without starting gameplay systems too early.

## What Changed In This Pass

- classic Mana-series motifs were added to deepen the world
- temple arcs were upgraded from progression nodes to layered sacred questlines
- the project now has a clearer mythic identity beyond the original *Secret of Mana* pacing
- Chapters 1 and 2 now have structured scene and quest mirrors under `game/data/`
- Chapter 6 is now drafted around the Upper Land and Wind Sanctuary arc
- Chapter 7 is now drafted around the Fire Palace borderland and false-map catastrophe arc
- Chapter 8 is now drafted around Kakkara's occupation corridor, aquifer diversion, and the sandship manifest handoff
- Chapter 9 is now drafted around the sandship, split-town occupation, and the route into the Lofty Mountains
- Chapter 10 is now drafted around Lofty Mountains scrutiny, the Moon Palace curated-grief archive, and the Tasnica high-pass handoff
- Chapter 11 is now drafted around Tasnica alliance politics, Jema's treaty debt, and the Light Palace legitimacy dispute
- Chapter 12 is now drafted around the Light Palace legitimacy engine, corrected-record exposure, and the Dark Palace route handoff
- Wind Sanctuary and Fire Palace leadership are now named in the faction layer
- Tasnica's first concrete contact point is now locked to the reopened sky routes in Chapter 6
- Portrait Batch 01 is now locked
- the first Chapter 1 combat benchmark is now locked to the Forbidden Falls seal breach arena
- early reward variance and Pandora conservative-contact visibility are now defined
- the actual Godot project shell now exists under `game/`
- a playable prototype slice now exists with movement, dialogue, map switching, and the first Water Palace / Forbidden Falls graybox benchmarks
- a tracked PowerShell wrapper now launches Godot with workspace-scoped appdata for reliable CLI validation
- the prototype now reads Chapter 1-2 scene and quest YAML mirrors for benchmark labels, prompts, and runtime narrative text
- the prototype now executes a linear Chapter 1 scene sequence with active quest state and resulting flag updates sourced from the editorial mirrors
- the prototype now advances Chapter 1 through in-world completion triggers and restores saved runtime state from `user://`
- the prototype now hands off from Chapter 1 into Chapter 2 and uses a dedicated Pandora benchmark map for the second playable slice
- the Chapter 2 Pandora slice now routes across separate gate-district, court-route, and annex/lower-gate grayboxes instead of compressing the whole chapter into one civic-knot map
- the runtime now opens with a visible continue/restart flow, saves a campaign-level checkpoint, and transitions between chapters through a dedicated chapter card instead of an abrupt dialogue jump
- the first Pandora visual/blockout pass now covers the gate district, court route, and annex/lower-gate route with a shared palette and stronger district reads
- a Chapter 2 headless playpass check now validates the full wired route end-to-end across all 8 scenes
- the first playable-slice plan now defines what is runnable today, what remains editorial only, and what should happen next to turn the Chapter 1-2 route into an internal review build

## Immediate Priority Order

### 1. Implement The First Chapter 2 Polish Pass

Reason:

- the Pandora slice now reads as one city and validates end-to-end, so the highest-value next pass is to sharpen Primm's join beat, court-route pursuit tension, and ledger recovery clarity without overbuilding systems

### 2. Add A Reviewer-Friendly Chapter 1-2 Access Path

Reason:

- the current slice can be played, but rapid review still leans too much on hidden debug-map knowledge and prior implementation context

### 3. Package The Chapter 1-2 Route As The First Internal Playable Thing

Reason:

- once the current slice is easier to review, the next leverage comes from making it repeatable for other eyes instead of keeping it as an implementation-only prototype

## Pre-Programming Sequence After That

1. Continue narrative production with Chapter 13
2. Mirror later stable chapters into deeper scene and quest YAML only when needed
3. Extend the current playable slice only after the Chapter 1-2 review build is stable

## Open Decisions That Still Matter

- how directly to import broader Mana-series peoples versus keeping them as lighter setting influence
- whether Popoi's people become a major late-game reveal or a distributed mystery
- exact timing of when later overt Pandora conservative-imperial coordination becomes public

## Recommended Creative Guardrails

- keep the emotional spine of *Secret of Mana*
- deepen the world without overcrowding it
- use classic Mana motifs as resonance, not franchise clutter
- let temples reveal moral compromises, not only lore
- keep each major revelation tied to character pain, not only ancient history
