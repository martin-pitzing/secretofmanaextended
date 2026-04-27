# Chapter 1 Sandbox Placeholder Sprite Guide

## Purpose

Define how the first Chapter 1 placeholder sprites should be authored so the `Chapter 1 Character Sandbox` becomes a reliable art-and-readability proving ground.

Use this guide before making the first placeholder sprites for:

- `Randi`
- `Potos Villager`
- `Water Palace Attendant`
- `Pandora Refugee`
- `Rabite Echo`

For the current deterministic first pass, use:

```powershell
.\tools\generate-ch01-sandbox-placeholders.ps1
```

## Output Targets

The sandbox currently checks these paths:

- `game/art/ch01/characters/randi/sandbox_placeholder.png`
- `game/art/ch01/characters/potos_villager/sandbox_placeholder.png`
- `game/art/ch01/characters/water_palace_attendant/sandbox_placeholder.png`
- `game/art/ch01/characters/pandora_refugee/sandbox_placeholder.png`
- `game/art/ch01/characters/rabite_echo/sandbox_placeholder.png`

## Base Format Rules

### Humans

- canvas: `32x32`
- transparent background
- one centered standing pose
- default facing: `south` or `south-three-quarters`, whichever reads cleaner in the semi-overhead lane
- feet anchor: place the grounded foot line around `y = 24-26`
- target visible body height: about `24-28 px`
- color count target: `8-14` colors before transparency

### Small Monster

- canvas: `32x32`
- transparent background
- one centered idle pose
- feet or bounce shadow anchor: around `y = 22-25`
- target visible body mass: about `18-24 px`
- color count target: `6-12` colors before transparency

## Read Priorities

These are more important than finish:

1. silhouette
2. faction or region read
3. combat readability
4. palette separation from the sandbox pod
5. expression and small trim details

If detail hurts silhouette, remove detail.

## Character-by-Character Starting Rules

### Randi

- read: practical village boy becoming a hero
- silhouette anchor: short sword-forward traveler
- palette lane: earth-tone traveler with one readable mana-story accent later, not yet now
- avoid making him look armored, noble, or too polished

### Potos Villager

- read: rural river community member with old ward culture embedded in daily wear
- silhouette anchor: workwear, rope, apron, shawl, or layered village cloth
- palette lane: cedar, linen, moss, muted clay
- avoid generic tavern-fantasy peasant styling

### Water Palace Attendant

- read: institutional sacred worker, not court servant
- silhouette anchor: practical ritual robe, sash, basin-work or archive-work trim
- palette lane: ivory, turquoise, muted gold, blue-white highlights
- avoid luxury-noble silhouette or heavy priest regalia

### Pandora Refugee

- read: civic strain and displacement made visible on one body
- silhouette anchor: bundle, patched travel layer, weight carried forward
- palette lane: worn crimson, dusted neutrals, muted civic cloth, strain not grime-for-grime's-sake
- avoid making them just a dirty villager copy

### Rabite Echo

- read: cute monster first, enemy second, but still readable in combat
- silhouette anchor: round body, ear shape, springy readiness
- palette lane: soft cream, warm blush, or one readable corruption tint if needed
- avoid over-detailing the face until it loses enemy clarity

## Tuning Loop

For each placeholder sprite:

1. drop the file into the target path
2. boot the sandbox with dev tools
3. compare the sprite against:
   - the pod background
   - the player footprint
   - nearby interact prompts
   - the combat pod if hostile
4. decide whether the problem is:
   - silhouette
   - palette contrast
   - footprint scale
   - pose direction
   - costume noise
5. revise only that problem first

## Fast Approval Rule

A placeholder sprite is good enough for first pass when:

- it reads cleanly at gameplay distance
- it immediately belongs to Chapter 1
- it does not collide with prompt readability
- it does not require close zoom to understand role
- it gives the sandbox a more truthful actor read than the polygon fallback
