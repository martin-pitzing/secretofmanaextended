# Chapter 2: Pandora Under Strain

- Chapter ID: `ch02_pandora_under_strain`
- Boundary: `Pandora gate district -> first contact with Primm -> court conflict -> Dyluck mission fallout -> first explicit imperial political pressure -> departure toward the goblin route and deeper Pandora crisis`
- Tone: civic pressure, noble suffocation, and rising regional dread
- Route model: one canonical route with optional social and investigation beats

## Marked Changes From Original Secret Of Mana

- **Original anchor: Pandora is an early kingdom in crisis and Primm is introduced through court conflict and Dyluck's disappearance.**
- **Added revisit change: Pandora's crisis is treated as political, logistical, and spiritual at the same time, not only as a backdrop for recruiting Primm.**
- **Added revisit change: the first explicit imperial pressure arrives through diplomacy, informants, and soft capture before full occupation.**
- **Added revisit change: Dyluck's mission is framed as a partly sacrificial political decision by the court, not a simple heroic absence.**

## Chapter Thesis

Pandora is still standing, but only because every institution inside it is deciding who can be spent.

## Emotional Arc

- Randi learns that exile was only the smallest scale of the world's fear-politics.
- Primm moves from constrained court daughter to active defector.
- Pandora shifts from "next town" into the first full example of how Mana crisis fractures a state from within.

## Playable Objectives

- secure a foothold in Pandora after arriving from the Water Palace
- witness the kingdom's public strain and private court fracture
- meet Primm through action, not exposition alone
- learn the truth of Dyluck's mission as rumor before confirmation
- survive the city's first direct encounter with imperial political pressure

## Gameplay Lane For This Chapter

Use the canonical terminology in `docs/action-rpg-terminology.md`.

Primary scene roles in Chapter 2:

- `social zone`: `Gate District Morning After`, `Rumors Of Dyluck`, `Terms Of Alliance`
- `pursuit lane`: `Court Wall, Garden Breach`
- `civic stage`: `The Court Divides`, `Kroll's Offer`
- `infiltration route`: `The Mission Ledger`
- `departure route`: `Departure Through The Lower Gate`

The chapter should read as a city-scale action RPG route:

- gate district scenes prove civic read and party-state setup
- the breach proves pursuit readability and route pressure
- the safehouse proves alliance lock and party-state transition
- the annex proves objective clarity under infiltration and combat pressure
- the lower gate proves outbound momentum rather than chapter drift

## Character Development Goals

- Randi: learns that institutions weaponize symbols just as villages weaponize superstition
- Primm: chooses rupture over obedience, but not without cost
- Luka: remains a remote influence whose guidance is now tested by court realities
- Dyluck: becomes emotionally real through testimony, letters, and competing political interpretations
- Kroll: becomes the first imperial face, precise and dangerous without open violence

## Faction Pressures Active In This Chapter

- Pandora conservatives want stability, secrecy, and deniable contact with the Empire through documents, proxies, and quiet access concessions rather than open collaboration
- reform voices want transparency and civilian protection
- military leadership is divided between noble legitimacy and wartime necessity
- the Water Palace is treated as useful but intrusive
- imperial pressure arrives through messages, trade control, and recognition politics

## Scene List

### Scene: Gate District Morning After

- Scene ID: `ch02_sc01_gate_district_morning_after`
- Location: Pandora outer district, inn, and ration lines
- Participants: Randi, innkeeper, civilians, guards, aid workers
- Trigger: start of Chapter 2
- Player control state: exploration and social inquiry
- Player goal: orient within Pandora and gather the first coherent picture of the kingdom's crisis
- Narrative beat: the city is orderly on the surface because pain has been pushed outward
- Gameplay beat: social navigation, information gathering, optional side interactions
- Exit condition: player learns of court restrictions, public fear, and Primm's unrest
- Resulting flags: `flag_region_pandora_civic_pressure_seen`
- Art requirements: market strain props, ration lines, posted decrees, guard checkpoints

### Scene: Rumors Of Dyluck

- Scene ID: `ch02_sc02_rumors_of_dyluck`
- Location: tavern corners, guard posts, relief district
- Participants: Randi, veterans, commoners, wounded courier, reform sympathizer
- Trigger: completing the morning inquiry
- Player control state: social investigation
- Player goal: collect contradictory accounts of Dyluck's last mission
- Narrative beat: the truth has already been broken into political versions
- Gameplay beat: optional dialogue routes, note-based clue collection
- Exit condition: player learns Dyluck may have been sent toward a mission no one expected him to survive
- Resulting flags: `flag_character_dyluck_mission_doubt_seeded`
- Art requirements: wounded-soldier props, relief district dressing, rumor-board or posted casualty notices

### Scene: Court Wall, Garden Breach

- Scene ID: `ch02_sc03_court_wall_garden_breach`
- Location: restricted court-adjacent district and service gardens
- Participants: Randi, Primm, court guards, one servant contact
- Trigger: after rumor investigation when the player approaches restricted zones
- Player control state: exploration into pursuit sequence
- Player goal: avoid arrest or expulsion while helping Primm escape immediate confinement
- Narrative beat: Primm enters as an active political actor, not a passive runaway
- Gameplay beat: stealth-light route, short chase, gate timing, improvised escape path
- Exit condition: Randi and Primm reach temporary cover in a lower district refuge
- Resulting flags: `flag_character_primm_contact_made`
- Art requirements: walled-garden route, noble/service contrast, pursuit path markers

### Scene: Terms Of Alliance

- Scene ID: `ch02_sc04_terms_of_alliance`
- Location: abandoned shrine-room or civic safehouse inside Pandora
- Participants: Randi, Primm
- Trigger: escape from court pursuit
- Player control state: dialogue-led with limited movement
- Player goal: decide to travel together for aligned but not identical reasons
- Narrative beat: Primm's rebellion is clarified as political and personal at once
- Gameplay beat: branch-flavored dialogue that converges on alliance
- Exit condition: Primm joins the active party
- Resulting flags: `flag_character_primm_joined_party`
- Art requirements: small safehouse interior, improvised shelter props, quiet city ambience

### Scene: The Court Divides

- Scene ID: `ch02_sc05_pandora_court_divides`
- Location: court chamber, heard partly directly and partly through parallel city rumor
- Participants: Regan, Voss, Seremne, Halwen, guards, messenger staff
- Trigger: Primm's escape becomes known
- Player control state: hybrid cutscene and aftermath exploration
- Player goal: understand what Primm is fleeing and what Pandora is hiding
- Narrative beat: the court is formally split over Dyluck, imperial pressure, and the acceptable cost of survival
- Gameplay beat: cinematic scene followed by eavesdropping and document recovery
- Exit condition: player acquires proof that Dyluck's mission was politically contested
- Resulting flags: `flag_faction_pandora_court_split_visible`, `flag_character_dyluck_mission_brief_fragment_found`
- Art requirements: court chamber, sealed records, messenger props, heraldic damage signs

### Scene: Kroll's Offer

- Scene ID: `ch02_sc06_kroll_offer`
- Location: public civic square or diplomatic receiving hall
- Participants: Magistrate Severin Kroll, Pandora officials, civilians, Randi and Primm at a distance or in disguise
- Trigger: after court split becomes visible
- Player control state: observation, optional stealth movement, no combat
- Player goal: witness the first direct imperial intervention
- Narrative beat: the Empire offers order in language designed to sound humane and inevitable, and the player can sense that parts of Pandora's conservative apparatus were already prepared for the performance
- Gameplay beat: overheard diplomacy, crowd reactions, optional pursuit if the player investigates too closely
- Exit condition: Kroll departs after leaving a formal "peace" proposal and implicit threat
- Resulting flags: `flag_faction_empire_kroll_seen`, `flag_faction_empire_soft_capture_visible`
- Art requirements: diplomatic staging, imperial insignia, civilian crowd reaction set

### Scene: The Mission Ledger

- Scene ID: `ch02_sc07_mission_ledger`
- Location: archive annex, military storehouse, or Seremne-linked relief office
- Participants: Randi, Primm, archivist contact, hostile guards
- Trigger: after witnessing Kroll's offer
- Player control state: exploration, puzzle-light infiltration, possible brief combat
- Player goal: secure a partial ledger showing who authorized Dyluck's route and why
- Narrative beat: Dyluck was sent on a mission framed as strategic necessity and symbolic sacrifice, and the recovered paperwork shows conservative accommodation pressure without an openly signed betrayal
- Gameplay beat: infiltration, key retrieval, patrol avoidance or small skirmish
- Exit condition: ledger fragment recovered and escape completed
- Resulting flags: `flag_character_dyluck_mission_brief_partial_recovered`, `flag_faction_pandora_conservative_complicity_suspected`
- Art requirements: archive annex, storage props, guarded corridor tiles, ledger item art

### Scene: Departure Through The Lower Gate

- Scene ID: `ch02_sc08_departure_lower_gate`
- Location: Pandora lower district and outbound road toward the goblin route
- Participants: Randi, Primm, civilians, relief workers, militia remnants
- Trigger: ledger fragment recovered
- Player control state: final social beats into departure
- Player goal: leave Pandora with purpose rather than drift
- Narrative beat: Primm becomes a defector from her own system, and Randi commits to a wider conflict
- Gameplay beat: shopping/tutorial-lite party changes, optional farewell beats, route handoff
- Exit condition: party departs Pandora and the next route unlocks
- Resulting flags: `flag_chapter_ch02_complete`, `flag_region_pandora_internal_crisis_active`
- Art requirements: lower gate route, departure props, mixed civilian/military traffic

## Quest Flow

## Quest: Read The City

- Quest ID: `q_ch02_001_read_the_city`
- Chapter ID: `ch02_pandora_under_strain`
- Unlock: chapter start
- Objectives: investigate the gate district, relief pressure, and Dyluck rumors
- Optional branches: speak with aid workers, displaced merchants, and a veteran who blames the court instead of the Empire
- Fail or soft-lock conditions: none
- Rewards: access to the deeper Pandora conflict
- Resulting flags: `flag_region_pandora_civic_pressure_seen`, `flag_character_dyluck_mission_doubt_seeded`
- Related scenes: `ch02_sc01_gate_district_morning_after`, `ch02_sc02_rumors_of_dyluck`

## Quest: Aid The Fugitive Princess

- Quest ID: `q_ch02_002_aid_the_fugitive_princess`
- Chapter ID: `ch02_pandora_under_strain`
- Unlock: Dyluck rumors collected
- Objectives: help Primm escape immediate court recapture, reach cover, form alliance
- Optional branches: gather a discarded court token or servant's testimony
- Fail or soft-lock conditions: none; Primm must join here
- Rewards: Primm joins the party, direct access to court-level stakes
- Resulting flags: `flag_character_primm_joined_party`
- Related scenes: `ch02_sc03_court_wall_garden_breach`, `ch02_sc04_terms_of_alliance`

## Quest: Witness The Terms Of Peace

- Quest ID: `q_ch02_003_witness_the_terms_of_peace`
- Chapter ID: `ch02_pandora_under_strain`
- Unlock: Primm joins
- Objectives: learn how the court is split, witness Kroll's intervention, understand the shape of imperial soft capture
- Optional branches: observe crowd reactions in different districts
- Fail or soft-lock conditions: none
- Rewards: explicit imperial antagonist presence and stronger Pandora context
- Resulting flags: `flag_faction_pandora_court_split_visible`, `flag_faction_empire_kroll_seen`
- Related scenes: `ch02_sc05_pandora_court_divides`, `ch02_sc06_kroll_offer`

## Quest: Recover The Mission Ledger

- Quest ID: `q_ch02_004_recover_the_mission_ledger`
- Chapter ID: `ch02_pandora_under_strain`
- Unlock: after Kroll's offer
- Objectives: infiltrate annex/storehouse, recover Dyluck mission fragment, escape with proof
- Optional branches: preserve secrecy or deliberately leak parts of the ledger to reform contacts
- Fail or soft-lock conditions: none
- Rewards: Dyluck route confirmation, Pandora departure hook, deeper mistrust of court conservatives
- Resulting flags: `flag_character_dyluck_mission_brief_partial_recovered`, `flag_region_pandora_internal_crisis_active`
- Related scenes: `ch02_sc07_mission_ledger`, `ch02_sc08_departure_lower_gate`

## Optional Side Objectives

- Side objective ID: `q_ch02_101_relief_crate_diversion`
- Purpose: show that Seremne's faction is quietly redirecting palace resources to civilians
- Outcome: improves later reform contact trust and grants a small `relief satchel` utility reward

- Side objective ID: `q_ch02_102_service_passage_map`
- Purpose: discover old service passages beneath the court district that reveal how often noble crisis and sacred architecture overlap
- Outcome: unlocks later city reentry shortcuts and grants a light `court runner sash` route utility reward

## World-State Outputs

- `flag_region_pandora_civic_pressure_seen`
- `flag_character_dyluck_mission_doubt_seeded`
- `flag_character_primm_joined_party`
- `flag_faction_pandora_court_split_visible`
- `flag_faction_empire_kroll_seen`
- `flag_faction_empire_soft_capture_visible`
- `flag_character_dyluck_mission_brief_partial_recovered`
- `flag_region_pandora_internal_crisis_active`
- `flag_chapter_ch02_complete`

## Art Requirements List

### Environment Sets

- Pandora ration district expansion
- court wall and service garden route
- interior safehouse
- court chamber and archive annex
- diplomatic receiving square
- lower gate departure route

### Character And Crowd Requirements

- Primm Chapter 2 first-join look
- Regan, Voss, Seremne, Halwen
- Kroll direct scene presentation
- relief workers, guards, veterans, servants, diplomatic attendants

### Interaction Requirements

- restricted-zone signage and noble-state barriers
- rumor boards, casualty ledgers, ration stamps
- archive keys, sealed folders, messenger wax marks

## Benchmark Candidate Added By This Chapter

- Pandora archive annex

Reason:

- it ties court secrecy, faction pressure, Dyluck's mission, and playable infiltration into one contained space

## Handoff To Chapter 3

Chapter 3 should move outward from Pandora's political crisis into the deeper material history of Mana, forging, buried infrastructure, and Popoi's eventual arrival.
