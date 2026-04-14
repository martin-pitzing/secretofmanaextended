# Chapter 1: Falls To Pandora

- Chapter ID: `ch01_falls_to_pandora`
- Boundary: `Potos -> exile -> wilderness transition -> Water Palace approach -> Pandora arrival and first political contact`
- Tone: melancholic mythic adventure with political weight
- Route model: one canonical route with optional flavor scenes that preserve the same outcome

## Chapter Thesis

The world does not break in one dramatic instant. It reveals that it has already been held together by damaged traditions, exhausted institutions, and political compromises that no longer work.

## Emotional Arc

- Randi moves from belonging to stigma to uncertain purpose.
- The player sees that mana imbalance is both supernatural and social.
- The chapter ends not with safety, but with the realization that every authority is incomplete.

## Playable Objectives

- survive the first monster destabilization
- leave Potos after exile
- reach the Water Palace and receive the first larger mandate
- witness that temple guidance is not politically neutral
- arrive at Pandora and feel court strain before the broader party fully forms

## Character Development Goals

- Randi: exile becomes a lived wound, not a quick tutorial beat
- Primm: introduced as someone already in conflict with court expectations
- Luka: useful, credible, and still strategically incomplete
- Pandora leadership: presented as divided before the player understands every detail

## Faction Pressures Active In This Chapter

- Potos elders and villagers split between fear and shame
- Falls shrine custodians want containment, not heroism
- Water Palace authority is respected but quietly resented
- Pandora court politics are already under wartime strain
- the Empire is felt through rumor, supply instability, and political pressure rather than open battlefield occupation

## Scene List

### Scene: Potos Morning

- Scene ID: `ch01_sc01_potos_morning`
- Location: Potos village and river edge
- Participants: Randi, village children, elders, local shrine voices
- Trigger: chapter start
- Player control state: full exploration tutorial-light
- Player goal: move through daily spaces and establish normal relationships
- Narrative beat: Potos feels warm but built around half-understood caution
- Gameplay beat: light exploration, first object interactions, soft environmental teaching
- Exit condition: party of boys pushes toward the forbidden falls
- Resulting flags: `flag_chapter_ch01_started`
- Art requirements: Potos exterior, homes, river shrine details, village props

### Scene: The Forbidden Falls

- Scene ID: `ch01_sc02_forbidden_falls`
- Location: waterfall approach and seal site
- Participants: Randi, village boys, seal-monster encounter
- Trigger: leaving Potos during Scene 1
- Player control state: exploration into first danger beat
- Player goal: survive the encounter and pull the sword during crisis
- Narrative beat: the seal was containment, not mere superstition
- Gameplay beat: first real threat, scripted pressure, sword acquisition moment
- Exit condition: monster defeated and ritual balance visibly destabilized
- Resulting flags: `flag_character_randi_has_mana_sword`, `flag_region_potos_seal_broken`
- Art requirements: waterfall map, seal altar, first destabilization effects, monster FX

### Scene: Judgment At Potos

- Scene ID: `ch01_sc03_judgment_at_potos`
- Location: Potos central gathering space
- Participants: Randi, Elder Truff, villagers, Sister Yselle messenger presence or equivalent shrine voice
- Trigger: return from the falls
- Player control state: mostly dialogue scene with short walkable beats
- Player goal: endure the accusation and understand the social rupture
- Narrative beat: fear chooses a scapegoat faster than truth can organize itself
- Gameplay beat: dialogue navigation, spatial repositioning through an angry crowd
- Exit condition: exile declared and escort to village boundary completed
- Resulting flags: `flag_character_randi_exiled`, `flag_region_potos_panic`
- Art requirements: crowd variants, village square setup, ritual-mark props

### Scene: Exile Road

- Scene ID: `ch01_sc04_exile_procession`
- Location: forest path beyond Potos
- Participants: Randi, escorting villagers, first roaming monsters
- Trigger: exile ruling
- Player control state: controlled path movement transitioning to combat tutorial
- Player goal: survive outside protection and push forward alone
- Narrative beat: exile becomes practical abandonment, not symbolic punishment
- Gameplay beat: early combat, path hazards, first survival pacing
- Exit condition: village escorts retreat and player gains independent movement
- Resulting flags: `flag_region_potos_return_locked_initial`
- Art requirements: forest edge tiles, path props, low-threat enemy set

### Scene: Water Palace Approach

- Scene ID: `ch01_sc05_water_palace_approach`
- Location: river route and palace exterior grounds
- Participants: Randi, palace attendants, wandering pilgrims, Archivist Neral
- Trigger: reaching the palace region
- Player control state: exploration with directed conversations
- Player goal: reach the palace and learn why the sword matters beyond Potos
- Narrative beat: the temple order is organized, strained, and not universally trusted
- Gameplay beat: navigation, environmental storytelling, side conversations that seed politics
- Exit condition: entry to Luka's chamber granted
- Resulting flags: `flag_region_water_palace_arrived`
- Art requirements: palace exterior, causeways, attendants, archival props

### Scene: Luka's Charge

- Scene ID: `ch01_sc06_luka_charge`
- Location: Water Palace inner chamber
- Participants: Randi, Luka, Archivist Neral, attendants
- Trigger: arrival in Luka's chamber
- Player control state: dialogue-led with single ritual interaction
- Player goal: understand the immediate quest and the limits of what Luka can explain
- Narrative beat: restoration is necessary, but it is also political and partial
- Gameplay beat: first major lore delivery, flag setup, ritual activation moment
- Exit condition: player receives direction toward Pandora and the next proof of world instability
- Resulting flags: `flag_faction_water_palace_contact_established`, `flag_quest_q_ch01_003_seek_pandora_open`
- Art requirements: benchmark room interior, ritual basin, mana-light effects

### Scene: Road To Pandora

- Scene ID: `ch01_sc07_road_to_pandora`
- Location: route between Water Palace and Pandora outskirts
- Participants: Randi, refugees, merchants, border runners
- Trigger: Luka's charge
- Player control state: exploration plus optional encounters
- Player goal: reach Pandora while gathering evidence of the wider crisis
- Narrative beat: instability is regional, not local
- Gameplay beat: travel combat, optional side objective, overheard worldbuilding
- Exit condition: player reaches Pandora gate district
- Resulting flags: `flag_region_pandora_approach_seen`
- Art requirements: travel route variants, refugee props, merchant and checkpoint dressing

### Scene: Pandora At The Edge

- Scene ID: `ch01_sc08_pandora_gate_district`
- Location: Pandora outer district and gate approach
- Participants: Randi, guards, civilians, signs of court strain, indirect Primm setup
- Trigger: arrival at Pandora
- Player control state: walkable social zone with restricted access points
- Player goal: enter, orient, and witness the kingdom's internal strain
- Narrative beat: Pandora is still functioning, but only by forcing crisis inward
- Gameplay beat: social navigation, access denial, faction pressure visualization
- Exit condition: player reaches a stable inn or safe civic node and receives the next chapter handoff
- Resulting flags: `flag_region_pandora_entered`, `flag_faction_pandora_instability_visible`
- Art requirements: gate district, guards, civilian crowding, emergency notices, ration props

## Quest Flow

## Quest: Leave Potos

- Quest ID: `q_ch01_001_leave_potos`
- Chapter ID: `ch01_falls_to_pandora`
- Unlock: chapter start
- Objectives: explore Potos, follow the boys to the falls, survive the seal incident
- Optional branches: talk to shrine-linked villagers for early lore flavor
- Fail or soft-lock conditions: none; the sequence is linear
- Rewards: Mana Sword acquisition, initial world destabilization
- Resulting flags: `flag_character_randi_has_mana_sword`, `flag_region_potos_seal_broken`
- Related scenes: `ch01_sc01_potos_morning`, `ch01_sc02_forbidden_falls`

## Quest: Accept Exile

- Quest ID: `q_ch01_002_accept_exile`
- Chapter ID: `ch01_falls_to_pandora`
- Unlock: seal broken
- Objectives: return to Potos, endure judgment, survive the first road beyond the village
- Optional branches: speak to one sympathetic villager before departure
- Fail or soft-lock conditions: none; exile must occur
- Rewards: independent overworld movement, emotional grounding of Randi's arc
- Resulting flags: `flag_character_randi_exiled`, `flag_region_potos_panic`
- Related scenes: `ch01_sc03_judgment_at_potos`, `ch01_sc04_exile_procession`

## Quest: Seek The Water Palace

- Quest ID: `q_ch01_003_seek_water_palace`
- Chapter ID: `ch01_falls_to_pandora`
- Unlock: exile complete
- Objectives: reach the palace, gain audience with Luka, receive next directive
- Optional branches: converse with palace attendants and pilgrims about temple distrust
- Fail or soft-lock conditions: none
- Rewards: first macro-story mandate, Water Palace contact, direction toward Pandora
- Resulting flags: `flag_faction_water_palace_contact_established`
- Related scenes: `ch01_sc05_water_palace_approach`, `ch01_sc06_luka_charge`

## Quest: Witness Pandora's Strain

- Quest ID: `q_ch01_004_witness_pandora_strain`
- Chapter ID: `ch01_falls_to_pandora`
- Unlock: Luka's charge
- Objectives: travel to Pandora, observe crisis markers, secure a foothold in the city edge
- Optional branches: help a displaced merchant family recover a seized crate or warning ledger
- Fail or soft-lock conditions: none
- Rewards: Pandora entry, faction setup for Primm and court conflict
- Resulting flags: `flag_region_pandora_entered`, `flag_faction_pandora_instability_visible`
- Related scenes: `ch01_sc07_road_to_pandora`, `ch01_sc08_pandora_gate_district`

## Optional Side Objective

- Side objective ID: `q_ch01_101_river_warning_ledger`
- Purpose: reveal that rural communities track mana irregularities better than courts assume
- Unlock: after exile during the road sequence
- Outcome: a recovered ledger can later let Luka or a Pandora contact acknowledge that village knowledge was ignored
- Narrative use: reinforces Potos as part of a real river-community network

## World-State Outputs

- `flag_character_randi_exiled`: Randi is socially severed from Potos
- `flag_region_potos_panic`: Potos enters a fear-dominated regional state
- `flag_faction_water_palace_contact_established`: Luka's authority is now active in the story
- `flag_faction_water_palace_trust_low`: default initial trust state; respect without surrender
- `flag_region_pandora_entered`: Pandora becomes the next active story node
- `flag_faction_pandora_instability_visible`: court strain is now on-screen and playable

## Art Requirements List

### Environment Sets

- Potos exterior day set
- Potos interior residential set
- waterfall and seal site set
- forest exile road set
- Water Palace exterior set
- Water Palace benchmark interior chamber
- Pandora gate district set

### Character And Crowd Requirements

- Randi Chapter 1 travel sprite direction
- Elder Truff and village crowd variants
- Sister Yselle or shrine emissary direction
- Luka and Archivist Neral
- refugees, merchants, guards, Pandora civilians
- first imperial officer silhouette presence reserved for notices, rumors, or distant insignia

### Enemy Requirements

- first destabilized monster family
- low-threat roadside enemy family

## Character Art Briefs Needed Before Implementation

### Randi

- early silhouette should read rural, not royal
- clothing must show recent exile by the end of the chapter
- sword should look sacred and dangerous, not fully restored

### Primm

- chapter 1 brief should emphasize noble structure under strain rather than full party readability
- first appearances should signal agency inside confinement

### Popoi

- use only as foreshadowing in Chapter 1
- no full introduction yet
- visual hints may appear through motifs or rumor, not a full character asset set

### Pandora Court Figures

- Regan, Voss, Seremne, and Halwen need distinct silhouettes readable in dialogue portraits and later sprites

### First Imperial Officer Silhouette

- use Magistrate Severin Kroll as the first named imperial presence through decrees, intermediaries, or insignia

## Benchmark Room Spec: Water Palace Inner Chamber

- Location: `reg_water_palace`
- Purpose: first authoritative mana briefing and ritual contact point
- Mood: serene order under subtle institutional strain
- Required tile sets: pale stone floors, channel inlays, ceremonial platforms, archive-adjacent furnishing
- Required props: ritual basin, suspended braziers, script stands, water channels, attendant markers
- Interaction points: audience approach, ritual focus point, optional archive-adjacent conversation node
- Combat use: none in Chapter 1 benchmark version
- VFX needs: controlled mana glow, reflected water light, subtle ritual activation effect
- Lighting notes: calm, cool, sacred, but not purely peaceful

## Handoff To Chapter 2

Chapter 2 should open from inside Pandora's strained civic and court space, where Primm's personal conflict and the regional political conflict finally collide directly.
