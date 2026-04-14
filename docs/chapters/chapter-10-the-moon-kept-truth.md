# Chapter 10: The Moon-Kept Truth

- Chapter ID: `ch10_the_moon_kept_truth`
- Boundary: `Lofty Mountains ascent -> charter scrutiny at the switchbacks -> night-wayhouse refuge -> Moon Palace outer cloister -> curated dream archive breach -> false Dyluck audience -> Moon Seed restoration -> Tasnica high-pass handoff`
- Tone: altitude, tenderness, and the horror of discovering that mercy can harden into a system of rule
- Route model: one canonical route with optional witness, sleep-ward, and testimony branches

## Marked Changes From Original Secret Of Mana

- **Original anchor: the Lofty Mountains and Moon Palace tie highland travel, illusion, and emotional uncertainty into one late-rising sacred route.**
- **Added revisit change: the mountains are now governed by charter law, avalanche ropes, weather shrines, and hidden wayhouses, making passage itself a political system instead of empty transition space.**
- **Added revisit change: the Moon Palace is no longer only dreamlike; it is an archive of curated grief where comfort has been formalized into doctrine and quietly borrowed by states.**
- **Added revisit change: Tasnica and the Moon Keepers are now in tension over who gets to interpret dream records, turning the chapter into a conflict over memory governance rather than a simple mystical detour.**

## Chapter Thesis

When truth is rationed for the sake of stability, comfort stops being kindness and becomes a tool of power.

## Emotional Arc

- Randi confronts the difference between protecting someone and deciding what they are allowed to know.
- Primm is offered the most dangerous version of hope so far: a Dyluck who feels emotionally true but is being used to keep her governable.
- Popoi experiences the Moon Palace as a field of half-preserved lives, sharpening the sense that memory can be archived without fully surviving.
- The party learns that anti-imperial powers and sacred orders alike will hide behind mercy when they fear the cost of disclosure.

## Playable Objectives

- carry the recovered mountain charter into the Lofty Mountains and survive the social scrutiny of the pass system
- reach a night-wayhouse and learn why dream-fever pilgrims are being redirected toward Moon rites
- secure access to the Moon Palace without accepting the keepers' full framing of the crisis
- uncover the curated grief archive beneath the palace's consoling ritual surface
- reject the palace's false closure, restore the Moon Seed, and force hidden records back into motion
- choose what testimony travels onward and open the high pass toward Tasnica

## Character Development Goals

- Randi: begins to understand that withheld truth can look merciful to the one withholding it
- Primm: refuses consolation that costs her agency, even when it wounds her
- Popoi: reads emotional residue as another kind of endangered history
- The party: starts treating sacred institutions with the same investigative suspicion they now bring to imperial systems

## Faction Pressures Active In This Chapter

- the Moon Keepers are split between custodians of emotional triage and reformers who think the temple has crossed into benevolent censorship
- night-route clans rely on sleep rites and mourning guidance, but resent how much of their losses were filtered for them
- Tasnica high-pass agents want access to dream archives because they contain testimony, intelligence, and legitimacy claims
- imperial patrol remnants cannot hold the mountains directly, but still pressure the lower routes through permits, rumors, and informants
- Thanatos-linked grief disturbances are present at the edge of the chapter, not as open command, but as proof that curated sorrow is vulnerable to capture

## Scene List

### Scene: Charter At The Switchbacks

- Scene ID: `ch10_sc01_charter_at_the_switchbacks`
- Location: lower Lofty switchbacks, charter posts, and bell-marked rope turns above the desert route
- Participants: party, pass clerks, rope wardens, mountain carriers, displaced travelers
- Trigger: Chapter 10 start
- Player control state: travel exploration under scrutiny
- Player goal: use the recovered charter to enter the mountain system and understand who is allowed to move upward
- Narrative beat: the mountains immediately reject the idea that freedom of movement is natural; every ascent is logged, judged, or quietly denied
- Gameplay beat: route reading, checkpoint dialogue, optional traveler aid, early hazard navigation
- Exit condition: party clears the lower scrutiny line and reaches the storm-marked upper paths
- Resulting flags: `flag_region_lofty_mountains_entered`, `flag_region_mountain_charter_system_seen`
- Art requirements: switchback paths, bell posts, weather ropes, charter boards, high-altitude watch shelters

### Scene: White Ropes, Sleepless Houses

- Scene ID: `ch10_sc02_white_ropes_sleepless_houses`
- Location: avalanche ropeway and hidden wayhouse hamlet above the marked pass
- Participants: party, night-route families, dream-fever pilgrims, rope tenders, exhausted shrine recorders
- Trigger: upper path instability reveals the need for shelter
- Player control state: exploration with rescue pressure
- Player goal: reach the wayhouse, stabilize frightened travelers, and understand why the region is pushing grief and sleep cases uphill
- Narrative beat: the mountain communities feel practical and sacred at once, relying on rites that work even as they suspect those rites are costing them truth
- Gameplay beat: rope timing, shelter activation, witness gathering, dream-struck NPC guidance
- Exit condition: party earns provisional trust and is shown the hidden record room beneath the wayhouse
- Resulting flags: `flag_region_night_wayhouse_reached`, `flag_region_mountain_dream_fever_visible`
- Art requirements: rope bridges, snow-shadow eaves, sleeping alcoves, bell ropes, wind-cut prayer cloth

### Scene: The Kindly Record

- Scene ID: `ch10_sc03_the_kindly_record`
- Location: sealed record room under the wayhouse
- Participants: party, Wayhouse Keeper Sen, reformer Moon attendant, Tasnica watcher, recorded dream fragments
- Trigger: trust granted at the wayhouse
- Player control state: investigation dialogue
- Player goal: learn what the Moon Palace has been doing to local grief records and secure a path-mark into the cloister
- Narrative beat: the temple's defenders are no longer abstract; they can explain exactly why they believed edited sorrow was the least cruel option
- Gameplay beat: ledger reading, testimony matching, route choice, archive inspection
- Exit condition: party receives a cloister mark and proof that local losses were curated for stability
- Resulting flags: `flag_faction_moon_keepers_contact_established`, `flag_faction_tasnica_high_pass_agents_seen`
- Art requirements: hidden ledgers, lacquered record drawers, dream bowls, coded wax markers, concealed shrine lamps

### Scene: Cloister Of Soft Light

- Scene ID: `ch10_sc04_cloister_of_soft_light`
- Location: Moon Palace outer cloister, petition halls, and sleep wards
- Participants: party, Moon Keepers, petitioners, shrine recorders, comfort attendants
- Trigger: cloister mark secured
- Player control state: social exploration
- Player goal: enter the palace without surrendering the party's suspicion and read the institution's public face
- Narrative beat: the Moon Palace is beautiful because it is designed to lower resistance, which makes every gesture of comfort feel politically charged
- Gameplay beat: petition hall navigation, overheard rites, optional witness conversations, symbolic-route reading
- Exit condition: party reaches the inner corridor where guided visions begin
- Resulting flags: `flag_region_moon_palace_reached`
- Art requirements: hanging veils, lantern constellations, moon pools, petition mats, silver-blue cloister stone

### Scene: Dreams That Answer Too Fast

- Scene ID: `ch10_sc05_dreams_that_answer_too_fast`
- Location: mirrored corridors and consolation chambers inside the palace
- Participants: party, guided visions, false echoes of loved ones, Moon ward guides
- Trigger: inner corridor entered
- Player control state: guided exploration with illusion pressure
- Player goal: navigate the palace's consoling route without accepting its offered answers as truth
- Narrative beat: each party member is shown an emotionally intelligent lie, revealing that the palace understands desire as a governance surface
- Gameplay beat: mirror routing, vision choice, memory resonance, false-exit rejection
- Exit condition: Primm's Dyluck vision collapses the guided route and opens the concealed archive path
- Resulting flags: `flag_character_primm_false_dyluck_encounter`, `flag_character_popoi_moon_memory_overlap`
- Art requirements: mirror halls, reflective pools, veiled bedchambers, silhouette doubles, broken light paths

### Scene: The Chamber Of Edited Nights

- Scene ID: `ch10_sc06_the_chamber_of_edited_nights`
- Location: hidden archive beneath the dream corridors
- Participants: party, Senior Custodian Meris, reformer attendants, Tasnica observer, sealed public grief records
- Trigger: guided route broken
- Player control state: confrontation and archive inspection
- Player goal: prove the palace has been editing public grief narratives and decide whether to release the records during the ritual crisis
- Narrative beat: the chapter's core moral conflict becomes explicit: if revelation will hurt people now, who gets to decide when they are allowed to hurt?
- Gameplay beat: archive decoding, testimony comparison, pressure dialogue, seal release setup
- Exit condition: the edited archive is exposed and the Moon Seed chamber opens under emergency rite
- Resulting flags: `flag_faction_moon_keepers_truth_exposed`, `flag_region_curated_grief_archive_opened`
- Art requirements: sealed archive doors, stacked sleep tablets, testimony curtains, moon-script shelves, emergency rite sigils

### Scene: Choose The Wound

- Scene ID: `ch10_sc07_choose_the_wound`
- Location: Moon Seed chamber and surrounding ritual basin
- Participants: party, Meris, reformer attendants, collapsing guided visions, dream-static entities
- Trigger: archive seals released
- Player control state: ritual confrontation
- Player goal: reject false closure, stabilize the Moon Seed, and survive the backlash of unedited dream flow
- Narrative beat: restoration here is not soothing; it means accepting that a truthful world is often harder to live in than a curated one
- Gameplay beat: pressure-phase fight, ritual anchor activation, vision-break timing, basin stabilization
- Exit condition: Moon Seed restored and the comfort lattice collapses into a more honest, less controlled flow
- Resulting flags: `flag_temple_moon_seed_restored`, `flag_region_mountain_dreams_unsealed`
- Art requirements: moon basin, shattered reflections, ritual lantern field, dream-static enemies, silver fracture light

### Scene: Pass To Tasnica

- Scene ID: `ch10_sc08_pass_to_tasnica`
- Location: high-pass overlook and reopened winter courier line beyond the palace
- Participants: party, night-route witnesses, reformer Moon attendants, Tasnica courier-captain, recovering petitioners
- Trigger: Moon Seed restored
- Player control state: aftermath and route handoff
- Player goal: decide what testimony leaves the mountains, read Tasnica's terms of contact, and commit to the next political horizon
- Narrative beat: relief does not bring innocence back; the party now moves toward Tasnica already knowing that allies also want ownership over truth
- Gameplay beat: witness placement, route confirmation, testimony choice, next-destination closure
- Exit condition: the Tasnica high pass is opened and the chapter closes
- Resulting flags: `flag_route_tasnica_high_pass_open`, `flag_chapter_ch10_complete`
- Art requirements: high-pass overlook, winter courier markers, opened signal braziers, witness bundles, distant fortress silhouette

## Quest Flow

## Quest: Climb By Charter

- Quest ID: `q_ch10_001_climb_by_charter`
- Chapter ID: `ch10_the_moon_kept_truth`
- Unlock: Chapter 10 start
- Objectives: use the recovered charter, pass the mountain scrutiny system, and reach shelter in the upper wayhouse
- Optional branches: help one displaced traveler or repair one warning bell line
- Fail or soft-lock conditions: none
- Rewards: access to the hidden wayhouse network and a first clear read on the mountain route order
- Resulting flags: `flag_region_lofty_mountains_entered`, `flag_region_mountain_charter_system_seen`, `flag_region_night_wayhouse_reached`
- Related scenes: `ch10_sc01_charter_at_the_switchbacks`, `ch10_sc02_white_ropes_sleepless_houses`

## Quest: Take The Cloister Mark

- Quest ID: `q_ch10_002_take_the_cloister_mark`
- Chapter ID: `ch10_the_moon_kept_truth`
- Unlock: wayhouse trust granted
- Objectives: inspect the hidden records, understand the Moon Keepers' split, and secure legal-sacred entry into the palace
- Optional branches: preserve one private testimony or identify one Tasnica watcher
- Fail or soft-lock conditions: none
- Rewards: Moon Keeper contact, palace access, and the first clear link between local mourning practice and state-level information control
- Resulting flags: `flag_faction_moon_keepers_contact_established`, `flag_faction_tasnica_high_pass_agents_seen`, `flag_region_moon_palace_reached`
- Related scenes: `ch10_sc03_the_kindly_record`, `ch10_sc04_cloister_of_soft_light`

## Quest: Break The Kindly Lie

- Quest ID: `q_ch10_003_break_the_kindly_lie`
- Chapter ID: `ch10_the_moon_kept_truth`
- Unlock: palace interior entered
- Objectives: survive the consoling vision route, refuse false closure, and expose the edited archive below the temple
- Optional branches: recover one erased village testimony or preserve one dream-map shard for later comparison
- Fail or soft-lock conditions: none
- Rewards: proof that curated grief has been formalized into temple governance and partially shared with nearby states
- Resulting flags: `flag_character_primm_false_dyluck_encounter`, `flag_character_popoi_moon_memory_overlap`, `flag_faction_moon_keepers_truth_exposed`, `flag_region_curated_grief_archive_opened`
- Related scenes: `ch10_sc05_dreams_that_answer_too_fast`, `ch10_sc06_the_chamber_of_edited_nights`

## Quest: Restore The Moon Seed

- Quest ID: `q_ch10_004_restore_the_moon_seed`
- Chapter ID: `ch10_the_moon_kept_truth`
- Unlock: edited archive exposed
- Objectives: stabilize the Moon Seed, survive the dream backlash, and carry surviving testimony toward the Tasnica pass
- Optional branches: decide which witness bundle leaves with the party or which remains with the reformers
- Fail or soft-lock conditions: none
- Rewards: Moon Seed restoration, reopened high-pass route, and a morally compromised but usable alliance horizon
- Resulting flags: `flag_temple_moon_seed_restored`, `flag_region_mountain_dreams_unsealed`, `flag_route_tasnica_high_pass_open`, `flag_chapter_ch10_complete`
- Related scenes: `ch10_sc07_choose_the_wound`, `ch10_sc08_pass_to_tasnica`

## Optional Side Objectives

- Side objective ID: `q_ch10_101_sleeping_names_ledger`
- Purpose: reconstruct one wayhouse ledger so missing mourners can be linked to the dream records that softened their public absence
- Outcome: increases later distrust of censored grief systems and strengthens witness credibility

- Side objective ID: `q_ch10_102_bellrope_witness_chain`
- Purpose: reconnect warning bells and rope signals so remote settlements can share news without waiting for the palace to filter it
- Outcome: reinforces the chapter's theme that communication itself is a form of political autonomy

## World-State Outputs

- `flag_region_lofty_mountains_entered`
- `flag_region_mountain_charter_system_seen`
- `flag_region_night_wayhouse_reached`
- `flag_region_mountain_dream_fever_visible`
- `flag_faction_moon_keepers_contact_established`
- `flag_faction_tasnica_high_pass_agents_seen`
- `flag_region_moon_palace_reached`
- `flag_character_primm_false_dyluck_encounter`
- `flag_character_popoi_moon_memory_overlap`
- `flag_faction_moon_keepers_truth_exposed`
- `flag_region_curated_grief_archive_opened`
- `flag_temple_moon_seed_restored`
- `flag_region_mountain_dreams_unsealed`
- `flag_route_tasnica_high_pass_open`
- `flag_chapter_ch10_complete`

## Art Requirements List

### Environment Sets

- lower Lofty switchbacks and charter posts
- avalanche ropeway and hidden wayhouse hamlet
- wayhouse record room
- Moon Palace outer cloister and petition halls
- mirrored consolation corridors
- hidden edited archive
- Moon Seed chamber and high-pass overlook

### Character And Crowd Requirements

- Wayhouse Keeper Sen portrait and mountain-guide silhouette
- Senior Custodian Meris portrait and ritual silhouette
- reformer Moon attendants and petition hall clerks
- night-route families, rope tenders, and dream-fever pilgrims
- Tasnica courier-captain and high-pass watchers
- false Dyluck vision portrait treatment

### Interaction Requirements

- charter boards, rope bells, and avalanche signal posts
- sleep ledgers, dream bowls, and testimony tablets
- mirror-route interactions and false-exit cues
- Moon Seed ritual anchors and archive seal mechanics
- one strong visual contrast between the palace's soothing public face and the severe archive below

## Transition Forward

Chapter 11 should carry the party through the Tasnica high pass into open alliance politics, where the Moon Palace testimony collides with Queen Adrielle's strategic hunger for controlled truth and the Empire's next sacred target.
