# Scene Data

This folder mirrors stable scene specs from the Markdown chapter packages.

Structure:

- one subfolder per chapter (`ch01/`, `ch02/`, ...)
- one YAML file per scene
- IDs must stay identical to the editorial scene IDs in `docs/chapters/`

Current status:

- Chapters 1 and 2 are mirrored at the scene level
- files are implementation-facing editorial mirrors, not final runtime payloads

Required fields per file:

- `id`
- `chapter_id`
- `title`
- `source_doc`
- `status`
- `sequence`
- `location`
- `participants`
- `trigger`
- `player_control_state`
- `player_goal`
- `narrative_beat`
- `gameplay_beat`
- `exit_condition`
- `resulting_flags`
- `art_requirements`
