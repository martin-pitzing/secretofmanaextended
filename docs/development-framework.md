# Secret of Mana Revisited: Development Framework

## Short Recommendation

Use **Godot 4.4+** for the game and **Aseprite** for the art pipeline.

Why:

- best balance of 2D tooling, low overhead, source control friendliness, and custom pixel workflows
- easier to keep a handcrafted pixel identity than in heavier 3D-first engines
- good fit for action RPG combat, tilemaps, shaders, dialogue tools, and moddable data-driven content
- practical for a greenfield indie project without forcing a huge rendering or build pipeline

Do **not** start in a 3D engine if the goal is "detailed pixel RPG that does not resemble the HD remake."

## Engine Comparison

### Godot 4.4+

Best fit if you want:
- top-down action combat
- layered tilemaps and event-driven maps
- custom lighting and weather over pixel art
- fast iteration with a small team
- clean open-source tooling

Watch-outs:
- you need discipline around pixel-perfect camera rules
- you should define rendering constraints early to avoid shimmer and scale drift

### Unity

Use only if:
- you already have a strong Unity pipeline
- you want to rely on specific middleware or an existing Unity team

Why not first choice:
- more overhead for this style of project
- easier to drift toward generic post-processed pixel aesthetics
- licensing and package churn add noise in preproduction

### Unreal

Not recommended for the first build of this project.

Reason:
- excellent engine, wrong weight class for a 2D-first pixel action RPG unless you already have deep Unreal expertise and a very specific hybrid rendering plan

## Visual Direction

Target:

- top-down pixel action RPG
- high-detail environments
- readable combat silhouettes
- painterly lighting without abandoning crisp sprites
- richer than SNES, but still unmistakably pixel-authored

Avoid:

- plastic 3D character models
- smooth-shaded chibi remakes
- excessive bloom or fake-retro filters
- thin sprites on huge empty maps

Reference lane:

- "hand-authored pixel diorama" rather than "retro nostalgia filter"
- dense environmental storytelling
- expressive animation priority on idle, cast, hit, and traversal states

## Pixel Spec Recommendation

Start with this production target:

- base internal resolution: `480x270` for early prototyping
- shipping exploration target: scale up to a `16:9` presentation with fixed integer scaling where possible
- character sprite body height: `32px to 48px`
- boss sprites: `96px to 192px+`
- tiles:
  - collision/base tiles around `16x16`
  - detail overlays and set pieces allowed to break tile bounds

Why this works:

- enough room for facial reads, cloth layers, props, temple ornament, and spell effects
- still clearly pixel art
- easier to animate than very large HD-2D style characters

## Art Pipeline

### Core Tools

- Aseprite for sprite sheets, tiles, animation timing, palette work
- Tiled or Godot TileMap for region blockouts
- Krita or Photoshop for concept sheets, paintovers, and promo art
- TexturePacker only if export management becomes painful
- FMOD optional for adaptive audio later; not needed on day one

### Asset Categories

1. Character sprites
2. Enemy sprites
3. Boss sprite sets
4. Tile sets per biome
5. Temple architecture kits
6. UI and menu icons
7. Spell and status VFX
8. Portraits and dialogue expressions
9. World map and travel presentation

### Style Rules

- use restrained palettes per biome with one accent range for mana phenomena
- keep outlines selective, not universal
- preserve material readability: moss, stone, silk, bronze, crystal, ash
- animate secondary motion in capes, braids, leaves, water edges, and altar flames
- make magic effects geometric and ritualistic, not only explosive

## Narrative Production Framework

Use a data-driven structure from the start.

Recommended content units:

- `region`
- `chapter`
- `town`
- `dungeon`
- `temple`
- `faction_event`
- `party_scene`
- `boss_encounter`
- `cutscene`

Recommended rule:
No temple should exist only as a dungeon. Every temple gets:

- a local crisis
- a keeper or ideological steward
- a faction stake
- a party conflict beat
- a post-restoration world-state change

## Combat And Systems Framework

Preserve the spirit of *Secret of Mana* without copying its rough edges blindly.

Keep:

- real-time melee spacing
- weapon identity
- companion synergy
- elemental magic acquisition through spirits
- layered towns/fields/dungeons rhythm

Improve:

- hit feedback and enemy telegraphing
- collision clarity
- AI companion reliability
- spell readability in crowded scenes
- boss phase identity
- traversal and puzzle integration with magic

Recommended system pillars:

1. stamina or timing-based melee cadence instead of pure spam
2. weapon schools with stance or upgrade branches
3. elemental affinity affecting traversal, status, and boss interactions
4. party relationship unlocks tied to combo skills or support actions
5. region corruption states that alter enemies and side quests

## Suggested Technical Stack

### Runtime

- Godot 4.4+
- GDScript first
- C# only if a system becomes performance-critical or tooling-heavy

### Data

- JSON or YAML for dialogue and quest data
- CSV only for quick balancing tables
- one canonical ID scheme for quests, scenes, enemies, items, spells, regions

### Version Control

- Git
- Git LFS only for large binary source art and audio if needed

### Project Structure

```text
secretofmana-extended/
  docs/
  game/
    scenes/
    scripts/
    systems/
    data/
    art/
      sprites/
      tilesets/
      portraits/
      vfx/
    audio/
    ui/
  tools/
  references/
```

## Vertical Slice Recommendation

Build one polished slice before full production.

Best slice:

- Potos outskirts
- waterfall and sword event
- first monster surge
- Water Palace exterior
- short Pandora segment
- one expanded dungeon segment with one boss

The slice should prove:

- camera and movement feel
- combat readability
- dialogue and cutscene pacing
- tile density and lighting style
- one temple-adjacent story beat
- one magic acquisition moment

## Base Frameworks To Build First

1. Player controller
2. Party follow and swap system
3. Melee and hit reaction framework
4. Spell casting and elemental affinity system
5. Dialogue and portrait framework
6. Quest/state flag system
7. Tile interaction and traversal tools
8. Boss state machine
9. Save/load and world-state persistence
10. Content authoring format for chapters and cutscenes

## Recommended Milestones

### Milestone 0: Preproduction

- lock visual target
- lock chapter 1 to chapter 3 narrative outline
- build concept sheets for main trio and one temple region

### Milestone 1: Playable Prototype

- movement
- one weapon
- one companion
- one spell
- one enemy family
- one boss

### Milestone 2: Vertical Slice

- full opening flow
- final-quality environment benchmark
- party banter and cutscene benchmark

### Milestone 3: Production Pipeline

- asset naming rules
- map construction rules
- scene scripting rules
- testing checklist for combat and progression locks

## Immediate Next Deliverables

1. character design sheets for Randi, Primm, and Popoi reinterpretations
2. one temple art bible
3. combat prototype in Godot
4. chapter 1 script draft
5. UI style board for menus, dialogue, and spell rings

## Source Notes

Context informed by:

- Wikipedia development notes on cut content and the abandoned broader structure: https://en.wikipedia.org/wiki/Secret_of_Mana
- Wiki of Mana story and systems overview: https://wikiofmana.com/wiki/Secret_of_Mana
- GameFAQs route structure for pacing analysis: https://gamefaqs.gamespot.com/snes/588646-secret-of-mana/faqs/17119
