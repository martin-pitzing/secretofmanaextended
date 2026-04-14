# Chapter 9: The Sandship And The Split Towns

- Chapter ID: `ch09_the_sandship_and_the_split_towns`
- Boundary: `Kakkara departure -> sandship rendezvous -> moving cargo deck infiltration -> Southtown permit facade -> Northtown labor underside -> transit core rupture -> mountain-route charter recovery -> Lofty Mountains handoff`
- Tone: motion, scrutiny, and the horror of discovering that an occupation can be designed to look efficient from every angle except the one its victims inhabit
- Route model: one canonical route with optional witness, rescue, and manifest-side branches

## Marked Changes From Original Secret Of Mana

- **Original anchor: the Sandship, Southtown, Northtown, and imperial travel pressure make the Empire tangible across transport routes and occupied settlements.**
- **Added revisit change: the Sandship is now a mobile extraction and transfer platform linking water theft, labor movement, and relic cargo into one visible imperial machine.**
- **Added revisit change: Southtown and Northtown are no longer simply two towns on the route; they function as paired faces of one occupation system, with polished civic compliance above and coercive throughput below.**
- **Added revisit change: Director Elra Vey enters the story directly here, making Mana Engineering feel present as a disciplined logistical science rather than only secret lab work.**

## Chapter Thesis

If power can decide who moves, who waits, and who disappears into transit, it can make domination feel like administration.

## Emotional Arc

- Randi learns that freedom of movement is itself a political privilege, not a neutral fact of travel.
- Primm sees civility weaponized as camouflage, forcing her to confront how often courts call a thing "stable" once the suffering has been moved out of sight.
- Popoi starts reading engines, manifest lines, and transport wards as memory systems, deepening the idea that extraction can erase a people without ever burning their homes.

## Playable Objectives

- follow the recovered manifest to the imperial sandship corridor
- board or shadow the sandship long enough to prove how transport, labor, and relic cargo are linked
- enter Southtown and read the polished face of occupation
- uncover Northtown as the concealed labor and transfer underside of the same civic machine
- confront Director Elra Vey's transport-calibration program and expose the transit core beneath the twin-town system
- secure the charter and route intelligence that open the path toward the Lofty Mountains

## Character Development Goals

- Randi: begins measuring justice by who gets to remain visible inside a system
- Primm: sees that public order can be engineered to make cruelty socially deniable
- Popoi: recognizes that transport systems can store and destroy identity just as archives do
- The party: starts targeting the connective tissue of imperial rule instead of only surviving the edge of it

## Faction Pressures Active In This Chapter

- Southtown merchants and civic managers want the town to stay prosperous enough to avoid becoming Northtown
- Northtown laborers, carriers, and captive crews are trying to remain legible to one another inside a system built to reduce them to throughput
- General Cassian Rourke wants the corridor to keep moving even if public trust collapses
- Director Elra Vey wants live calibration data from transport wards, mover engines, and relic shielding
- Magistrate Severin Kroll wants every transfer point to read as orderly consent rather than coercion
- smuggling networks, hidden dockhands, and overland couriers are turning manifests into one of the only ways to track the disappeared

## Scene List

### Scene: Manifest Across The Dunes

- Scene ID: `ch09_sc01_manifest_across_the_dunes`
- Location: wind-cut dunes, buried track pylons, and moving shade markers between Kakkara and the sandship corridor
- Participants: party, desert couriers, convoy fragments, hidden spotters, displaced transport workers
- Trigger: Chapter 9 start
- Player control state: travel exploration
- Player goal: follow the recovered manifest trail and find where the sandship actually meets the inland corridor
- Narrative beat: the desert is no longer empty between towns; it has become a governed interval of checkpoints, rendezvous logic, and moving visibility
- Gameplay beat: route tracking, optional witness rescue, tracker-marker reading, low-pressure skirmishes
- Exit condition: party reaches the sandship rendezvous zone
- Resulting flags: `flag_region_sandship_route_entered`
- Art requirements: dune track pylons, buried guidance rails, mobile shade rigs, convoy trace markers, long-distance hull silhouette

### Scene: Hull On The Horizon

- Scene ID: `ch09_sc02_hull_on_the_horizon`
- Location: sandship loading basin and escort perimeter
- Participants: party, loading crews, desert guards, captive workers, manifest clerks
- Trigger: arriving at the rendezvous zone
- Player control state: stealth-leaning observation
- Player goal: read the ship's loading logic and gain access without losing the manifest trail
- Narrative beat: the sandship feels less like a vehicle and more like a moving border
- Gameplay beat: patrol timing, disguise or blind-spot movement, overheard loading calls, boarding setup
- Exit condition: party gains hidden access to the ship's active cargo deck
- Resulting flags: `flag_region_sandship_seen`, `flag_region_sandship_boarded`
- Art requirements: sandship hull, cargo ramps, loading cages, escort pennants, ballast machinery

### Scene: Cargo Of The Disappeared

- Scene ID: `ch09_sc03_cargo_of_the_disappeared`
- Location: sandship manifest deck, sealed cargo galleries, and transport registry alcoves
- Participants: party, manifest records, captive crews, Popoi resonance bleed, imperial deck staff
- Trigger: ship access gained
- Player control state: infiltration exploration
- Player goal: prove that labor transfer, relic shielding, and civic permit control are running through the same manifest chain
- Narrative beat: the Empire's paperwork is revealed as an engine of disappearance
- Gameplay beat: cargo-route puzzles, manifest recovery, hidden passenger discovery, optional rescue setup
- Exit condition: party confirms the ship links Kakkara, Southtown, and Northtown through one transfer program
- Resulting flags: `flag_region_sandship_manifest_verified`, `flag_faction_empire_transport_system_seen`
- Art requirements: deck ledgers, locked registry bays, transport wards, captive bunks, moving hull shadows

### Scene: Southtown By Permit Light

- Scene ID: `ch09_sc04_southtown_by_permit_light`
- Location: Southtown civic promenade, market terraces, and public permit offices
- Participants: party, Southtown merchants, clerks, guards, polished civic stewards, uneasy civilians
- Trigger: disembarking through the public town face
- Player control state: social exploration
- Player goal: understand how Southtown maintains the appearance of normal commercial life while the ship continues to carry people out of sight
- Narrative beat: a town can look peaceful because someone else has been assigned to absorb the violence required to keep it so
- Gameplay beat: permit observation, market inquiry, optional smuggler contact, civic-tone contrast reading
- Exit condition: party learns the labor and prisoner stream is being pushed into Northtown through a buried transit axis
- Resulting flags: `flag_region_southtown_entered`, `flag_region_southtown_facade_seen`
- Art requirements: shaded market walks, polished permit stands, transport notice boards, merchant awnings, hidden guard routes

### Scene: Backstairs To Northtown

- Scene ID: `ch09_sc05_backstairs_to_northtown`
- Location: maintenance corridors, freight lifts, and buried transfer stairs linking Southtown to Northtown
- Participants: party, smugglers, freight handlers, route watchers, hidden laborers
- Trigger: Southtown facade read correctly
- Player control state: traversal with stealth pressure
- Player goal: reach Northtown through the routes the public promenade is designed not to acknowledge
- Narrative beat: the split between the two towns is architectural denial made physical
- Gameplay beat: service-route traversal, freight timing, covert movement, helper NPC interactions
- Exit condition: party emerges into Northtown's active labor quarter
- Resulting flags: `flag_region_northtown_entered`, `flag_region_twin_town_link_exposed`
- Art requirements: freight lifts, service tunnels, hidden conveyor tracks, dim permit lamps, dust-heavy stairwells

### Scene: Northtown Under Load

- Scene ID: `ch09_sc06_northtown_under_load`
- Location: labor quarter, barracks streets, and transfer yards under Northtown
- Participants: party, labor crews, exhausted carriers, family searchers, guard captains, resistance contacts
- Trigger: entering Northtown
- Player control state: social exploration under threat
- Player goal: read Northtown as the labor underside of Southtown's prosperity and locate the transit core feeding both
- Narrative beat: the chapter's moral split becomes impossible to deny once the cost has a face, a queue, and a sleeping floor
- Gameplay beat: witness gathering, rescue setup, yard navigation, optional solidarity objectives
- Exit condition: party gains access coordinates to the twin-town transit core
- Resulting flags: `flag_region_northtown_system_read`
- Art requirements: barracks lanes, transfer yards, stacked cargo frames, worker queues, dim industrial shrine remnants

### Scene: Director Vey's Calibration

- Scene ID: `ch09_sc07_director_veys_calibration`
- Location: transit core gantries beneath the twin-town network
- Participants: party, Director Elra Vey, engineering crews, calibration devices, moving cargo lines
- Trigger: transit core coordinates secured
- Player control state: confrontation under system pressure
- Player goal: stop the calibration cycle and expose how the twin-town transport system is being tuned for imperial expansion beyond the desert
- Narrative beat: Vey reveals the Empire's technical worldview clearly: if a system works, its moral cost is a secondary variable
- Gameplay beat: pressure-phase confrontation, route rerouting, machinery hazards, evidence-driven exchange with Vey
- Exit condition: calibration fails, the transport core destabilizes, and the party seizes the mountain-route charter
- Resulting flags: `flag_faction_empire_vey_seen`, `flag_region_transit_core_reached`, `flag_faction_empire_transport_calibration_broken`
- Art requirements: gantries, conveyor arcs, calibration prisms, moving cargo cages, instrument glow

### Scene: Charter To The Heights

- Scene ID: `ch09_sc08_charter_to_the_heights`
- Location: broken transit overlook above Northtown's outbound route
- Participants: party, freed workers, resistance couriers, Southtown witnesses, distant imperial regrouping
- Trigger: transport calibration broken
- Player control state: aftermath and route handoff
- Player goal: decide what evidence remains local, read the recovered charter, and prepare the move into the Lofty Mountains
- Narrative beat: breaking the system does not free every captive route, but it gives the party the first document that points beyond the occupation corridor toward hidden orders and older heights
- Gameplay beat: aftermath closure, witness placement, charter reading, next-route confirmation
- Exit condition: the Lofty Mountains route is unlocked and the chapter closes
- Resulting flags: `flag_route_lofty_mountains_open`, `flag_chapter_ch09_complete`
- Art requirements: broken gantry edge, outbound switch markers, escaping crews, signal cloth, mountain-route horizon

## Quest Flow

## Quest: Trace The Sandship Manifest

- Quest ID: `q_ch09_001_trace_the_sandship_manifest`
- Chapter ID: `ch09_the_sandship_and_the_split_towns`
- Unlock: Chapter 9 start
- Objectives: follow the manifest trail, reach the sandship rendezvous, and gain access to the moving transport system
- Optional branches: help one displaced transport worker or preserve one route marker chain
- Fail or soft-lock conditions: none
- Rewards: sandship access and a first direct look at the Empire's moving extraction network
- Resulting flags: `flag_region_sandship_route_entered`, `flag_region_sandship_seen`, `flag_region_sandship_boarded`
- Related scenes: `ch09_sc01_manifest_across_the_dunes`, `ch09_sc02_hull_on_the_horizon`

## Quest: Read The Cargo Of The Disappeared

- Quest ID: `q_ch09_002_read_the_cargo_of_the_disappeared`
- Chapter ID: `ch09_the_sandship_and_the_split_towns`
- Unlock: sandship access gained
- Objectives: recover the shipboard records, prove the transport chain, and follow the manifest into Southtown
- Optional branches: free one hidden captive crew or preserve one registry crate for later testimony
- Fail or soft-lock conditions: none
- Rewards: explicit evidence that desert extraction, labor movement, and civic permits are linked
- Resulting flags: `flag_region_sandship_manifest_verified`, `flag_faction_empire_transport_system_seen`, `flag_region_southtown_entered`
- Related scenes: `ch09_sc03_cargo_of_the_disappeared`, `ch09_sc04_southtown_by_permit_light`

## Quest: Expose The Split Towns

- Quest ID: `q_ch09_003_expose_the_split_towns`
- Chapter ID: `ch09_the_sandship_and_the_split_towns`
- Unlock: Southtown entered
- Objectives: uncover the hidden route to Northtown, read the labor underside, and locate the transit core beneath both towns
- Optional branches: escort one family searcher or reconnect one secret dock signal line
- Fail or soft-lock conditions: none
- Rewards: full understanding of the twin-town occupation structure and access to the core
- Resulting flags: `flag_region_southtown_facade_seen`, `flag_region_northtown_entered`, `flag_region_twin_town_link_exposed`, `flag_region_northtown_system_read`
- Related scenes: `ch09_sc04_southtown_by_permit_light`, `ch09_sc05_backstairs_to_northtown`, `ch09_sc06_northtown_under_load`

## Quest: Break The Calibration And Take The Charter

- Quest ID: `q_ch09_004_break_the_calibration_and_take_the_charter`
- Chapter ID: `ch09_the_sandship_and_the_split_towns`
- Unlock: transit core coordinates secured
- Objectives: confront Elra Vey, break the transport calibration cycle, and secure the route charter toward the mountains
- Optional branches: preserve one intact calibration prism or decide which witness bundle leaves with the party
- Fail or soft-lock conditions: none
- Rewards: Vey's first direct defeat in the field, transport disruption, and the Lofty Mountains handoff
- Resulting flags: `flag_faction_empire_vey_seen`, `flag_region_transit_core_reached`, `flag_faction_empire_transport_calibration_broken`, `flag_route_lofty_mountains_open`, `flag_chapter_ch09_complete`
- Related scenes: `ch09_sc07_director_veys_calibration`, `ch09_sc08_charter_to_the_heights`

## Optional Side Objectives

- Side objective ID: `q_ch09_101_manifest_name_chain`
- Purpose: rebuild a chain of transfer names so one group of disappeared laborers can be traced across the ship and the towns
- Outcome: sharpens the chapter's "visibility versus disappearance" theme and strengthens later worker testimony

- Side objective ID: `q_ch09_102_permit_lantern_codes`
- Purpose: recover one hidden lantern-code set used by Southtown couriers to warn Northtown families about forced transfers
- Outcome: gives later resistance contacts more credibility and deepens the twin-town world texture

## World-State Outputs

- `flag_region_sandship_route_entered`
- `flag_region_sandship_seen`
- `flag_region_sandship_boarded`
- `flag_region_sandship_manifest_verified`
- `flag_faction_empire_transport_system_seen`
- `flag_region_southtown_entered`
- `flag_region_southtown_facade_seen`
- `flag_region_northtown_entered`
- `flag_region_twin_town_link_exposed`
- `flag_region_northtown_system_read`
- `flag_faction_empire_vey_seen`
- `flag_region_transit_core_reached`
- `flag_faction_empire_transport_calibration_broken`
- `flag_route_lofty_mountains_open`
- `flag_chapter_ch09_complete`

## Art Requirements List

### Environment Sets

- dune manifest trail and sandship rendezvous
- sandship cargo deck and registry alcoves
- Southtown civic promenade
- Southtown to Northtown service routes
- Northtown labor quarter
- twin-town transit core
- broken outbound charter overlook

### Character And Crowd Requirements

- Director Elra Vey field portrait and transit-core silhouette
- Southtown civic clerks and merchants
- Northtown labor crews and family searchers
- sandship deck guards, manifest clerks, and captive workers
- resistance couriers and signal-lantern carriers

### Interaction Requirements

- readable manifests and registry boards
- transport wards, calibration prisms, and cargo cage interactions
- permit-light signage versus hidden route signals
- one strong visual contrast between Southtown polish and Northtown throughput

## Transition Forward

Chapter 10 should carry the mountain-route charter into the Lofty Mountains and the hidden-order phase, where the party moves from imperial systems back into the higher sacred conflict they have now learned to distrust more intelligently.
