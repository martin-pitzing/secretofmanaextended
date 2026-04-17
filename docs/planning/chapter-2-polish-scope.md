# Secret of Mana Revisited: Chapter 2 Polish Scope

## Goal

Define the next gameplay-facing pass for the Pandora slice without prematurely expanding into full combat, stealth, or party systems.

## Validation Baseline

- gate district, court route, and annex/lower-gate benchmarks now share a stronger Pandora palette and dressing language
- the Chapter 2 route has passed a headless end-to-end validation pass through all 8 wired scenes
- current work should now focus on readability, tension, and payoff rather than additional benchmark sprawl

## Scope Decisions

### 1. Primm Join Presentation

Keep `Terms Of Alliance` as a dialogue-led safehouse beat with limited movement.

Add only:

- one clearer alliance-lock visual beat in the safehouse space
- stronger acknowledgement that Primm is now the active political hinge of the chapter
- one visible runtime confirmation that the party state has changed

Do not add:

- a full party menu
- party AI
- a deeper companion system pass

### 2. Court-Route Pursuit Tension

Keep the breach route as a small, legible pursuit encounter.

Add only:

- clearer breach-path pressure markers
- stronger guard-route readability and pursuit messaging
- one cleaner distinction between watched court space and the servant escape lane

Do not add:

- new enemy archetypes
- full stealth systems
- larger combat counts that would overwhelm the route read

### 3. Ledger Infiltration Pressure

Keep `The Mission Ledger` as a puzzle-light infiltration beat with optional brief combat.

Add only:

- one stronger archive target read so the ledger recovery point is unmistakable
- a clearer sense of guarded corridor pressure before the ledger interaction
- a cleaner outbound handoff into the lower-gate departure route

Do not add:

- an inventory puzzle layer
- patrol-state UI
- a large annex maze

## Next Implementation Target

Build a focused Chapter 2 polish pass around:

- Primm join presentation in the safehouse
- pursuit readability in the court route
- ledger-target clarity and escape pressure in the annex route
