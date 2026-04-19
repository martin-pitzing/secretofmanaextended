# Chapter 1 Environment Production Kits

## Purpose

Convert the Chapter 1 story package, current benchmark decisions, and original *Secret of Mana* location anchors into concrete environment-production kits that can drive Godot dressing work.

These kits should be used to move Chapter 1 beyond abstract graybox composition without jumping straight to final production art.

## Source Anchors

Use these sources together:

- original-material anchors preserved in `Potos`, `Forbidden Falls`, and `Water Palace`
- Chapter 1 story package in `docs/chapters/chapter-01-falls-to-pandora.md`
- scene mirrors in `game/data/scenes/ch01/`
- regional visual lane in `docs/art-direction-brief.md`
- first benchmark locks in `docs/visual-production-decisions.md`
- benchmark execution notes in `docs/art/water-palace-benchmark-checklist.md` and `docs/art/forbidden-falls-combat-benchmark-checklist.md`
- faction and temple context in `docs/faction-bible.md` and `docs/temples/water-palace.md`

## Shared Chapter 1 Guardrails

- preserve the original game's clean location read before adding extra detail
- add detail through material storytelling, ritual wear, and social use, not random clutter
- keep the Mana-series sense of wonder alive even when scenes are politically heavier
- make each space readable at gameplay camera distance before optimizing it for close inspection
- avoid remake-style gloss, high-bloom haze, or painterly smoothing that breaks pixel authorship
- make Chapter 1 feel rural, sacred, and unstable before it feels militarized

## Deliverable Shape For Each Kit

Each kit should produce:

- one palette target with dominant, support, and accent colors
- one reusable material library
- one prop family list split into must-have and second-pass elements
- one ambient and VFX list
- one Godot-first dressing target list
- one short "do not do" list to keep the lane clean

## Kit 1: Potos Prop + Material Kit

### Scene Coverage

- `ch01_sc01_potos_morning`
- `ch01_sc03_judgment_at_potos`
- `ch01_sc04_exile_procession`

### Original Anchor

Potos should still read as the classic opening village moral baseline from the original material:

- small
- warm
- river-linked
- deceptively safe

What the revisit adds is evidence that the village has been living beside a half-understood containment problem for generations.

### Story Function

- establish Randi's belonging before it is severed
- show that ordinary people live inside damaged sacred tradition
- make the judgment scene feel like a rupture of home, not a generic plot handoff

### Visual Thesis

Potos is not a generic fantasy hamlet. It is a river village built from wet wood, old caution, and domestic ritual habits that villagers no longer read as unusual.

The key read is:

- pastoral calm first
- old ward culture second
- fear under the surface third

### Palette Target

- dominant: cedar brown, damp wood gray-brown, soft moss green
- support: river-stone gray, reed tan, muted clay red, washed linen
- accent: cool water cyan, faded ward pigment red, small lantern gold

### Material Library

- wet cedar planks for walls, docks, rails, and fence runs
- river stones with worn carved ward signs
- reed rope, knot bundles, and lashings
- bark, wicker, and woven reed containers
- weathered shrine cloth faded by mist and river wind
- moss-darkened thresholds and damp footpaths
- chalk or pigment markings used for old warning or cleansing rites

### Must-Have Prop Family

- house-front variants with asymmetrical repair patches
- door charms, hanging knots, and protective tags
- river shrine stones or low roadside votive markers
- fishing baskets, poles, drying racks, and water jars
- communal benches, chopping stumps, hand carts, and bucket stacks
- flood-height markers and old warning posts near the river edge
- village-square ritual markers for the judgment scene:
  - boundary rope posts
  - accusation staffs
  - offering trays
  - crowd stools or portable stools

### Second-Pass Prop Family

- children's play objects that make the village feel inhabited before the break
- shrine gardener tools:
  - reed cutters
  - root-mark gloves
  - woven bark satchels
- river-warning ledgers or weathered notice boards
- prayer-strip clusters tied to bridge rails or trees
- ferry cleats, rope coils, and simple dock mooring details
- household drying cloth and patched awnings

### Spatial Dressing Rules

- cluster homes around shared practical activity, not decorative symmetry
- keep the village edge soft and organic; avoid hard plaza geometry
- place ward signs where locals would stop noticing them:
  - lintels
  - fence posts
  - path forks
  - river steps
- for the judgment scene, temporarily convert everyday space into ritual-social pressure space instead of inventing a separate courtroom
- make the route from village calm to exile boundary readable as one emotional line

### Ambient And VFX Notes

- waterfall mist drift and soft river shimmer
- subtle cloth or charm flutter on exposed edges
- light insect movement or shrine-insect hints near water and gardens
- one or two spiritual details only:
  - faint ward glow at a shrine marker
  - soft pollen-like drift near a tended root patch

### Godot-First Dressing Priorities

First pass should be enough to build:

- one modular Potos house exterior kit
- one village-square dressing pass
- one river-edge shrine corner
- one exile-boundary transition set using reused village materials in a harsher arrangement

Reusable scene pieces should include:

- door charm cluster
- ward-stone pair
- warning-post set
- fish-drying frame
- shrine table
- flood-mark post
- ritual accusation kit for the judgment scene

### Do Not Do

- do not make Potos feel wealthy, polished, or ornamental
- do not turn the village into generic medieval-Europe clutter
- do not overstate the taboo with overt horror dressing before the falls scene
- do not use hard military props this early

### Done Definition

The kit is done when:

- Potos reads as home before it reads as exposition
- the village square can stage both daily life and judgment without a second bespoke asset language
- the exile transition feels like the same community withdrawing protection rather than entering a new biome by accident

## Kit 2: Forbidden Falls Seal-Site Kit

### Scene Coverage

- `ch01_sc02_forbidden_falls`

### Original Anchor

This space should preserve the original material's strongest early icon:

- the forbidden waterfall
- the sword pull
- the broken seal
- the first sacred crisis

The revisit should deepen that icon by making the site feel like failing containment rather than abstract myth scenery.

### Story Function

- prove the first real danger beat
- make the sword pull feel consequential
- reveal that local superstition was a damaged version of real containment practice

### Visual Thesis

Forbidden Falls is a sacred edge-space where beauty, danger, and neglect occupy the same screen.

The room should read in this order:

- waterfall and altar focal point
- unstable footing and edge danger
- signs that villagers tried to keep people away
- post-rupture instability

### Palette Target

- dominant: wet stone gray-green, deep teal shadow, moss olive
- support: spray white, cold cyan reflection, weathered rope ochre
- accent: seal amber, rupture gold-white, restrained corrupted violet or unstable blue-white edge noise

### Material Library

- slick stone with darker water-soaked value bands
- moss and lichen patches that respect gameplay readability
- carved but eroded seal-stone surfaces
- rope warnings, stake remnants, and weathered shrine fiber
- broken debris from old containment work
- cliff-edge spray surfaces and shallow runoff cuts

### Must-Have Prop Family

- altar or seal-stone centerpiece with readable sword-contact face
- warning-post and rope-remnant set
- broken ward stakes or old barrier stones
- edge markers or cairns showing prior attempts at containment
- disturbed debris after the rupture
- one monster-emergence focal detail tied to the seal break, not random cave spawning

### Second-Pass Prop Family

- fallen offering bowls or old prayer tokens
- carved path markers leading into the approach lane
- spray-hit shrubs or roots bent by constant water force
- cracked side tablets or half-buried seal fragments
- one or two memory-artifact details:
  - river glass shard
  - warmed oath tablet fragment

### Structural And Layout Rules

- keep one clean altar focal read visible through the fight
- limit the room to one main approach lane and one obvious danger edge
- make pre-fight and post-fight versions clearly different without requiring a totally different tileset
- use broken footing, runoff, and water pressure to add danger before adding more enemies
- preserve a strong one-screen composition; this room should feel iconic, not sprawling

### Before / After State Change

The room should support both:

- sealed and tense
- ruptured and unstable

At minimum, the state change should affect:

- altar glow
- crack pattern or seal ring integrity
- debris placement
- water or mist response
- enemy emergence read

### Ambient And VFX Notes

- steady heavy waterfall bed before any special effect work
- pre-fight seal shimmer or pulse
- sword-contact rupture flash that stays pixel-authored and readable
- one spray surge or mist reaction tied to destabilization
- restrained edge-noise effect on the broken seal instead of late-game corruption spectacle

### Godot-First Dressing Priorities

First pass should build:

- one hero altar asset with swap states
- one waterfall-edge tile band
- one warning-marker set
- one debris cluster set for post-rupture dressing
- one simple hazard-edge treatment that reads at gameplay distance

Reusable pieces should include:

- rope-warning post
- broken ward stake
- seal-ring fragment
- wet-stone trim strip
- runoff crack decal

### Do Not Do

- do not turn the site into a big dungeon ruin
- do not drown the scene in purple corruption reads that belong to later chapters
- do not overcrowd the arena with foliage that hides melee reads
- do not use cinematic screen effects that blur pixel edges during the first major fight

### Done Definition

The kit is done when:

- the room feels sacred and dangerous before combat even begins
- the altar remains the unquestioned focal point during and after the fight
- the rupture reads as the loss of containment, not just a boss trigger

## Kit 3: Water Palace Tile + Archive Prop Kit

### Scene Coverage

- `ch01_sc05_water_palace_approach`
- `ch01_sc06_luka_charge`

### Original Anchor

The Water Palace should preserve the original material's core role:

- first major temple
- Luka's authority seat
- first clear sacred explanation space

The revisit pushes it toward a temple-archive institution where order, care, and withheld truth share the same architecture.

### Story Function

- prove the project's sacred-pixel visual lane
- support Luka's first audience and ritual scene
- show that temple authority is credible, useful, and still politically incomplete

### Visual Thesis

The Water Palace is serene authority under strain.

It should feel:

- calm
- luminous
- disciplined
- slightly withheld

The player should immediately understand that this is both a holy place and a working archive-state.

### Palette Target

- dominant: ivory stone, pale blue-gray, desaturated turquoise
- support: muted gold, pale aquamarine, archive-shadow blue
- accent: blue-white mana glow, reflected water light, restrained seal cyan

### Tile And Surface Library

- pale stone base floors with worn sacred geometry
- water-channel edge tiles and inlay variations
- raised dais or audience platform tiles
- threshold tiles separating public sacred space from restricted archive-adjacent space
- wall and pillar modules with controlled geometry, not cathedral heaviness
- reflection-friendly basin surrounds
- exterior causeway stone with water staining and route wear

### Must-Have Prop Family

- ritual basin
- suspended braziers
- script stands and reading lecterns
- sealed record cases or archive shelves
- attendant floor mats or audience markers
- ceremonial vessels
- water-channel grates or ritual outlet details
- route markers or satchel rests for archive staff and couriers

### Second-Pass Prop Family

- wax-case satchels and waterproof document tubes
- coded ribbons, seals, and tag markers on stored records
- small shrine lighting fixtures
- folded cloth screens or quiet dividers for archive-side privacy
- pilgrim offerings on the approach route
- attendant cleaning tools and basin-maintenance accessories
- one or two lightly used restricted-door markers

### Architectural Read Rules

- the room needs one strong central axis toward Luka's authority position
- a secondary read toward archives or sealed records must remain visible
- approach, audience, and ritual interaction should happen in one clean spatial sequence
- outer causeway dressing should make arrival feel procedural as well as sacred
- archive-side detail should imply restricted knowledge without turning the space into a library dungeon

### Lighting And VFX Notes

- cool sacred base light, never sterile white
- selective reflected-water shimmer near channels and basin
- subtle difference between ritual-side light and archive-side light
- drifting droplets or particle shimmer used sparingly
- one controlled ritual activation pulse from the basin
- no heavy combat spectacle and no remake-style bloom wash

### Crowd And Staff Dressing Notes

- attendants should read as practical ritual workers, not court luxury staff
- Archivist Neral's presence should be supported by record-moving props and route logic
- one or two pilgrims or waiting figures on the approach can suggest broader temple traffic without crowding the benchmark
- archive courier textures may appear here before becoming more politically visible in Chapter 2

### Godot-First Dressing Priorities

First pass should be enough to build:

- one short Water Palace approach or causeway set
- one benchmark inner chamber set
- one archive-side pocket for optional conversation
- one ritual interaction composition centered on the basin

Reusable scene pieces should include:

- channel edge tile band
- dais trim module
- script stand
- sealed record case
- attendant floor marker
- brazier pair
- courier-satchel cluster

### Do Not Do

- do not make the Water Palace look like a royal palace with water motifs
- do not overdecorate every surface with gold or carvings
- do not make the archive side gloomy enough to feel villainous
- do not flatten the room into pure calm; it should carry subtle institutional strain

### Done Definition

The kit is done when:

- the player immediately reads water, ritual, and archive functions as separate but related
- the chamber can stage Luka, Randi, and Neral cleanly without hiding the room's key props
- the room feels like the visual proof of the revisit's identity rather than a generic holy chamber

## Recommended Build Order

1. Water Palace tile + archive prop kit
2. Forbidden Falls seal-site kit
3. Potos prop + material kit

## Why This Order

- Water Palace is the main visual benchmark for the whole project
- Forbidden Falls is the strongest Chapter 1 combat and rupture proof-point
- Potos needs the broadest reusable village kit, so it benefits from the material and palette discipline established by the first two spaces
