# Quest Data

This folder mirrors stable quest specs from the Markdown chapter packages.

Structure:

- one subfolder per chapter (`ch01/`, `ch02/`, ...)
- one YAML file per quest or side objective
- IDs must stay identical to the editorial quest IDs in `docs/chapters/`

Current status:

- Chapters 1 and 2 are mirrored at the quest level
- files are implementation-facing editorial mirrors, not final runtime payloads

Required fields per file:

- `id`
- `chapter_id`
- `title`
- `source_doc`
- `status`
- `quest_type`
- `sequence`
- `unlock_condition`
- `objectives`
- `optional_branches`
- `fail_or_soft_lock_conditions`
- `rewards`
- `resulting_flags`
- `related_scene_ids`
