# Data Script Helpers

This folder holds lightweight runtime readers that bridge the editorial YAML mirrors in `res://data/` into the current Godot prototype.

Current contents:

- `editorial_yaml_loader.gd`: minimal YAML reader for the flat mirror format used by Chapters 1-2
- `chapter_content_repository.gd`: loads Chapter 1-2 scene and quest mirrors for prototype use

These helpers are intentionally narrow. They support the current editorial mirror structure and are not yet a general runtime schema layer.
