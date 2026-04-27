extends RefCounted

class_name PrototypePlaypassValidator

const PrototypeMapCatalogScript = preload("res://scripts/prototype/prototype_map_catalog.gd")


static func validate_chapter_playpass(module, repository, runtime) -> Array:
    var failures := []
    if module == null:
        failures.append("Missing chapter module instance for playpass validation.")
        return failures

    var chapter_id := str(module.get_chapter_id())
    var chapter_record: Dictionary = repository.get_chapter(chapter_id)
    if chapter_record.is_empty():
        failures.append("Missing chapter record for '%s'." % chapter_id)
        return failures

    var scene_order := _normalize_array(chapter_record.get("scene_ids", []))
    var expected_flags := _normalize_array(chapter_record.get("primary_flags", []))
    var expected_completion_triggers: Dictionary = module.get_expected_completion_trigger_ids()
    var expected_quest_completions: Dictionary = module.get_expected_quest_completions()

    for index in range(scene_order.size()):
        var scene_id := str(scene_order[index])
        _validate_scene_runtime(runtime, scene_id, failures)
        _validate_scene_map(module, runtime, scene_id, expected_completion_triggers, failures)

        var completion_result: Dictionary = runtime.complete_current_scene()
        var expected_quest_id := str(expected_quest_completions.get(scene_id, ""))
        var actual_quest_id := str(completion_result.get("quest_completed_id", ""))
        if actual_quest_id != expected_quest_id:
            failures.append("%s completed quest mismatch: expected '%s', got '%s'." % [scene_id, expected_quest_id, actual_quest_id])

        var is_last_scene := index == scene_order.size() - 1
        var chapter_complete := bool(completion_result.get("chapter_complete", false))
        if chapter_complete != is_last_scene:
            failures.append("%s chapter_complete mismatch: expected %s, got %s." % [scene_id, str(is_last_scene), str(chapter_complete)])

    var final_summary: Dictionary = runtime.get_progress_summary()
    if not bool(final_summary.get("chapter_complete", false)):
        failures.append("Chapter summary did not report completion after the final scene.")

    var flags: Array = runtime.get_flags()
    for expected_flag in expected_flags:
        if not flags.has(str(expected_flag)):
            failures.append("Missing expected final chapter flag '%s'." % str(expected_flag))

    return failures


static func _validate_scene_runtime(runtime, scene_id: String, failures: Array) -> void:
    var current_scene_id: String = str(runtime.get_current_scene_id())
    if current_scene_id != scene_id:
        failures.append("Runtime scene order mismatch: expected '%s', got '%s'." % [scene_id, current_scene_id])


static func _validate_scene_map(module, runtime, scene_id: String, expected_completion_triggers: Dictionary, failures: Array) -> void:
    var map_id := str(module.get_story_map_id(scene_id))
    var map_scene = PrototypeMapCatalogScript.get_map_scene(map_id)
    if map_scene == null:
        failures.append("No map scene configured for '%s' (%s)." % [scene_id, map_id])
        return

    var map_node = map_scene.instantiate()
    if map_node.has_method("apply_content_bundle"):
        map_node.apply_content_bundle(runtime.build_current_bundle())

    var actual_map_id := str(map_node.get_map_id())
    if actual_map_id != map_id:
        failures.append("%s map id mismatch: expected '%s', got '%s'." % [scene_id, map_id, actual_map_id])

    var world_rect: Rect2 = map_node.get_world_rect()
    var spawn_position: Vector2 = map_node.get_spawn_position()
    if not world_rect.has_point(spawn_position):
        failures.append("%s spawn position %s is outside world rect %s." % [scene_id, str(spawn_position), str(world_rect)])

    var wall_rects: Array = map_node.get_wall_rects()
    if _point_in_any_rect(spawn_position, wall_rects):
        failures.append("%s spawn position %s is inside a wall collider." % [scene_id, str(spawn_position)])

    var trigger_specs: Array = map_node.get_trigger_specs()
    if trigger_specs.is_empty():
        failures.append("%s does not expose any trigger specs." % scene_id)
        map_node.free()
        return

    var expected_completion_trigger := str(expected_completion_triggers.get(scene_id, ""))
    var found_completion_trigger := false
    for trigger_spec in trigger_specs:
        var trigger_id := str(trigger_spec.get("id", ""))
        var position: Vector2 = trigger_spec.get("position", Vector2.ZERO)
        if not world_rect.has_point(position):
            failures.append("%s trigger '%s' is outside world rect." % [scene_id, trigger_id])
        elif _point_in_any_rect(position, wall_rects):
            failures.append("%s trigger '%s' is placed inside a wall collider." % [scene_id, trigger_id])

        if trigger_id == expected_completion_trigger and bool(trigger_spec.get("completes_scene", false)):
            found_completion_trigger = true

    if not found_completion_trigger:
        failures.append("%s missing expected completion trigger '%s'." % [scene_id, expected_completion_trigger])

    for enemy_spec in map_node.get_enemy_specs():
        var enemy_position: Vector2 = enemy_spec.get("position", Vector2.ZERO)
        if not world_rect.has_point(enemy_position):
            failures.append("%s enemy position %s is outside world rect." % [scene_id, str(enemy_position)])
        elif _point_in_any_rect(enemy_position, wall_rects):
            failures.append("%s enemy position %s is inside a wall collider." % [scene_id, str(enemy_position)])

    map_node.free()


static func _point_in_any_rect(point: Vector2, rects: Array) -> bool:
    for rect in rects:
        if rect is Rect2 and rect.has_point(point):
            return true
    return false


static func _normalize_array(values) -> Array:
    if values is PackedStringArray:
        return Array(values)
    if values is Array:
        var normalized := []
        for value in values:
            normalized.append(str(value))
        return normalized
    return []
