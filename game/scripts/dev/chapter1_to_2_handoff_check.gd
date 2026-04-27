extends SceneTree

const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")
const ChapterRuntimeStateScript = preload("res://scripts/data/chapter_runtime_state.gd")
const PrototypeChapterRegistryScript = preload("res://scripts/prototype/prototype_chapter_registry.gd")
const PrototypePlaypassValidatorScript = preload("res://scripts/dev/prototype_playpass_validator.gd")

const CHAPTER_01_ID := "ch01_falls_to_pandora"
const CHAPTER_02_ID := "ch02_pandora_under_strain"


func _initialize() -> void:
    call_deferred("_run_validation")


func _run_validation() -> void:
    var failures := []
    var repository = ChapterContentRepositoryScript.new()
    repository.load_default_content()

    var chapter1_module = PrototypeChapterRegistryScript.get_module(CHAPTER_01_ID)
    var chapter2_module = PrototypeChapterRegistryScript.get_module(CHAPTER_02_ID)
    if chapter1_module == null or chapter2_module == null:
        push_error("Missing chapter modules for Chapter 1 -> Chapter 2 handoff validation.")
        quit(1)
        return

    var chapter1_runtime = ChapterRuntimeStateScript.new()
    chapter1_runtime.configure(repository, CHAPTER_01_ID)
    failures.append_array(PrototypePlaypassValidatorScript.validate_chapter_playpass(chapter1_module, repository, chapter1_runtime))

    var final_flags: Array = chapter1_runtime.get_flags()
    for required_flag in chapter2_module.get_required_handoff_flags():
        var normalized_flag := str(required_flag)
        if not final_flags.has(normalized_flag):
            failures.append("Chapter 1 does not export required Chapter 2 handoff flag '%s'." % normalized_flag)

    var chapter1_scene_ids: Array = repository.get_chapter(CHAPTER_01_ID).get("scene_ids", [])
    var chapter2_scene_ids: Array = repository.get_chapter(CHAPTER_02_ID).get("scene_ids", [])
    if chapter1_scene_ids.is_empty() or chapter2_scene_ids.is_empty():
        failures.append("One of the chapter manifests is missing scene_ids for handoff validation.")
    else:
        var chapter1_final_scene_id := str(chapter1_scene_ids[chapter1_scene_ids.size() - 1])
        var chapter2_entry_scene_id := str(chapter2_scene_ids[0])
        var chapter1_final_map_id := str(chapter1_module.get_story_map_id(chapter1_final_scene_id))
        var chapter2_entry_map_id := str(chapter2_module.get_story_map_id(chapter2_entry_scene_id))
        if chapter1_final_map_id != chapter2_entry_map_id:
            failures.append("Chapter handoff map mismatch: Chapter 1 ends on '%s' while Chapter 2 starts on '%s'." % [chapter1_final_map_id, chapter2_entry_map_id])

    var chapter2_runtime = ChapterRuntimeStateScript.new()
    chapter2_runtime.configure(repository, CHAPTER_02_ID)
    if chapter2_scene_ids.is_empty():
        failures.append("Chapter 2 handoff validation could not resolve an opening scene.")
    elif chapter2_runtime.get_current_scene_id() != str(chapter2_scene_ids[0]):
        failures.append("Chapter 2 runtime does not open on its first scene after configure().")

    var chapter2_quest_ids: Array = repository.get_chapter(CHAPTER_02_ID).get("quest_ids", [])
    var expected_opening_quest_id := ""
    if not chapter2_quest_ids.is_empty():
        expected_opening_quest_id = str(chapter2_quest_ids[0])
    if chapter2_runtime.get_active_quest_id() != expected_opening_quest_id:
        failures.append("Chapter 2 active opening quest mismatch: expected '%s', got '%s'." % [expected_opening_quest_id, chapter2_runtime.get_active_quest_id()])

    if failures.is_empty():
        print("Chapter 1 -> Chapter 2 handoff validation passed.")
        print("Verified Chapter 1 exports the required Pandora-entry flags and hands off into Chapter 2's opening route.")
        quit(0)
        return

    push_error("Chapter 1 -> Chapter 2 handoff validation failed.")
    for failure in failures:
        push_error(failure)
    quit(1)
