extends SceneTree

const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")
const ChapterRuntimeStateScript = preload("res://scripts/data/chapter_runtime_state.gd")
const PrototypeChapterRegistryScript = preload("res://scripts/prototype/prototype_chapter_registry.gd")
const PrototypePlaypassValidatorScript = preload("res://scripts/dev/prototype_playpass_validator.gd")

const CHAPTER_ID := "ch01_falls_to_pandora"


func _initialize() -> void:
    call_deferred("_run_validation")


func _run_validation() -> void:
    var repository = ChapterContentRepositoryScript.new()
    repository.load_default_content()

    var runtime = ChapterRuntimeStateScript.new()
    runtime.configure(repository, CHAPTER_ID)

    var module = PrototypeChapterRegistryScript.get_module(CHAPTER_ID)
    var failures: Array = PrototypePlaypassValidatorScript.validate_chapter_playpass(module, repository, runtime)
    var scene_count := Array(repository.get_chapter(CHAPTER_ID).get("scene_ids", [])).size()

    if failures.is_empty():
        print("Chapter 1 playpass validation passed.")
        print("Validated %d scenes across Potos, the falls, Water Palace, and Pandora entry." % scene_count)
        quit(0)
        return

    push_error("Chapter 1 playpass validation failed.")
    for failure in failures:
        push_error(failure)
    quit(1)
