extends SceneTree

const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")
const ChapterRuntimeStateScript = preload("res://scripts/data/chapter_runtime_state.gd")

const CHAPTER_ID := "ch02_pandora_under_strain"
const SCENE_ORDER := [
    "ch02_sc01_gate_district_morning_after",
    "ch02_sc02_rumors_of_dyluck",
    "ch02_sc03_court_wall_garden_breach",
    "ch02_sc04_terms_of_alliance",
    "ch02_sc05_pandora_court_divides",
    "ch02_sc06_kroll_offer",
    "ch02_sc07_mission_ledger",
    "ch02_sc08_departure_lower_gate"
]
const SCENE_TO_MAP := {
    "ch02_sc01_gate_district_morning_after": preload("res://scenes/prototype/maps/pandora_district_benchmark.tscn"),
    "ch02_sc02_rumors_of_dyluck": preload("res://scenes/prototype/maps/pandora_district_benchmark.tscn"),
    "ch02_sc03_court_wall_garden_breach": preload("res://scenes/prototype/maps/pandora_court_route_benchmark.tscn"),
    "ch02_sc04_terms_of_alliance": preload("res://scenes/prototype/maps/pandora_court_route_benchmark.tscn"),
    "ch02_sc05_pandora_court_divides": preload("res://scenes/prototype/maps/pandora_court_route_benchmark.tscn"),
    "ch02_sc06_kroll_offer": preload("res://scenes/prototype/maps/pandora_annex_route_benchmark.tscn"),
    "ch02_sc07_mission_ledger": preload("res://scenes/prototype/maps/pandora_annex_route_benchmark.tscn"),
    "ch02_sc08_departure_lower_gate": preload("res://scenes/prototype/maps/pandora_annex_route_benchmark.tscn")
}
const EXPECTED_MAP_IDS := {
    "ch02_sc01_gate_district_morning_after": "pandora_gate_district",
    "ch02_sc02_rumors_of_dyluck": "pandora_gate_district",
    "ch02_sc03_court_wall_garden_breach": "pandora_court_route",
    "ch02_sc04_terms_of_alliance": "pandora_court_route",
    "ch02_sc05_pandora_court_divides": "pandora_court_route",
    "ch02_sc06_kroll_offer": "pandora_annex_route",
    "ch02_sc07_mission_ledger": "pandora_annex_route",
    "ch02_sc08_departure_lower_gate": "pandora_annex_route"
}
const EXPECTED_COMPLETION_TRIGGERS := {
    "ch02_sc01_gate_district_morning_after": "relief_board",
    "ch02_sc02_rumors_of_dyluck": "wounded_courier",
    "ch02_sc03_court_wall_garden_breach": "garden_gap",
    "ch02_sc04_terms_of_alliance": "safehouse_lantern",
    "ch02_sc05_pandora_court_divides": "court_window",
    "ch02_sc06_kroll_offer": "kroll_dais",
    "ch02_sc07_mission_ledger": "ledger_annex",
    "ch02_sc08_departure_lower_gate": "lower_gate"
}
const EXPECTED_QUEST_COMPLETIONS := {
    "ch02_sc02_rumors_of_dyluck": "q_ch02_001_read_the_city",
    "ch02_sc04_terms_of_alliance": "q_ch02_002_aid_the_fugitive_princess",
    "ch02_sc06_kroll_offer": "q_ch02_003_witness_the_terms_of_peace",
    "ch02_sc08_departure_lower_gate": "q_ch02_004_recover_the_mission_ledger"
}


func _initialize() -> void:
    call_deferred("_run_validation")


func _run_validation() -> void:
    var failures := []
    var repository = ChapterContentRepositoryScript.new()
    repository.load_default_content()

    var runtime = ChapterRuntimeStateScript.new()
    runtime.configure(repository, CHAPTER_ID)

    var chapter_record := repository.get_chapter(CHAPTER_ID)
    var expected_flags: Array = chapter_record.get("primary_flags", [])

    for index in range(SCENE_ORDER.size()):
        var scene_id = SCENE_ORDER[index]
        _validate_scene_runtime(runtime, scene_id, failures)
        _validate_scene_map(runtime, scene_id, failures)

        var completion_result = runtime.complete_current_scene()
        var expected_quest_id = str(EXPECTED_QUEST_COMPLETIONS.get(scene_id, ""))
        var actual_quest_id = str(completion_result.get("quest_completed_id", ""))
        if actual_quest_id != expected_quest_id:
            failures.append("%s completed quest mismatch: expected '%s', got '%s'." % [scene_id, expected_quest_id, actual_quest_id])

        var is_last_scene := index == SCENE_ORDER.size() - 1
        var chapter_complete := bool(completion_result.get("chapter_complete", false))
        if chapter_complete != is_last_scene:
            failures.append("%s chapter_complete mismatch: expected %s, got %s." % [scene_id, str(is_last_scene), str(chapter_complete)])

    var final_summary = runtime.get_progress_summary()
    if not bool(final_summary.get("chapter_complete", false)):
        failures.append("Chapter summary did not report completion after the final scene.")

    var flags: Array = runtime.get_flags()
    for expected_flag in expected_flags:
        if not flags.has(str(expected_flag)):
            failures.append("Missing expected final chapter flag '%s'." % str(expected_flag))

    if failures.is_empty():
        print("Chapter 2 playpass validation passed.")
        print("Validated %d scenes across gate, court, and annex routes." % SCENE_ORDER.size())
        quit(0)
        return

    push_error("Chapter 2 playpass validation failed.")
    for failure in failures:
        push_error(failure)
    quit(1)


func _validate_scene_runtime(runtime, scene_id: String, failures: Array) -> void:
    var current_scene_id = runtime.get_current_scene_id()
    if current_scene_id != scene_id:
        failures.append("Runtime scene order mismatch: expected '%s', got '%s'." % [scene_id, current_scene_id])


func _validate_scene_map(runtime, scene_id: String, failures: Array) -> void:
    var map_scene: PackedScene = SCENE_TO_MAP.get(scene_id)
    if map_scene == null:
        failures.append("No map scene configured for '%s'." % scene_id)
        return

    var map_node = map_scene.instantiate()
    if map_node.has_method("apply_content_bundle"):
        map_node.apply_content_bundle(runtime.build_current_bundle())

    var expected_map_id = str(EXPECTED_MAP_IDS.get(scene_id, ""))
    var actual_map_id = str(map_node.get_map_id())
    if actual_map_id != expected_map_id:
        failures.append("%s map id mismatch: expected '%s', got '%s'." % [scene_id, expected_map_id, actual_map_id])

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
        return

    var expected_completion_trigger = str(EXPECTED_COMPLETION_TRIGGERS.get(scene_id, ""))
    var found_completion_trigger := false
    for trigger_spec in trigger_specs:
        var trigger_id = str(trigger_spec.get("id", ""))
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


func _point_in_any_rect(point: Vector2, rects: Array) -> bool:
    for rect in rects:
        if rect is Rect2 and rect.has_point(point):
            return true
    return false
