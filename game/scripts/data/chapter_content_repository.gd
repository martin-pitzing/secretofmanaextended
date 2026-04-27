extends RefCounted

class_name ChapterContentRepository

const EditorialYamlLoaderScript = preload("res://scripts/data/editorial_yaml_loader.gd")
const CHAPTER_DIR := "res://data/chapters"
const SCENES_ROOT_DIR := "res://data/scenes"
const QUESTS_ROOT_DIR := "res://data/quests"

var _scenes := {}
var _quests := {}
var _chapters := {}
var _scene_directories: Array = []
var _quest_directories: Array = []


func load_default_content() -> void:
    _scenes.clear()
    _quests.clear()
    _chapters.clear()
    _scene_directories.clear()
    _quest_directories.clear()

    _load_directory(CHAPTER_DIR, _chapters)

    _scene_directories = _discover_data_directories(SCENES_ROOT_DIR)
    _quest_directories = _discover_data_directories(QUESTS_ROOT_DIR)

    for directory in _scene_directories:
        _load_directory(directory, _scenes)

    for directory in _quest_directories:
        _load_directory(directory, _quests)


func get_scene(scene_id: String) -> Dictionary:
    return _scenes.get(scene_id, {})


func get_quest(quest_id: String) -> Dictionary:
    return _quests.get(quest_id, {})


func get_chapter(chapter_id: String) -> Dictionary:
    return _chapters.get(chapter_id, {})


func get_scene_count() -> int:
    return _scenes.size()


func get_quest_count() -> int:
    return _quests.size()


func get_chapter_count() -> int:
    return _chapters.size()


func get_chapter_ids() -> Array:
    var chapter_ids := []
    for chapter_id in _chapters.keys():
        chapter_ids.append(str(chapter_id))
    chapter_ids.sort()
    return chapter_ids


func get_scene_directories() -> Array:
    return _scene_directories.duplicate()


func get_quest_directories() -> Array:
    return _quest_directories.duplicate()


func build_bundle(scene_ids: Array, quest_ids: Array) -> Dictionary:
    var bundle := {
        "scene_ids": [],
        "quest_ids": [],
        "scenes": {},
        "quests": {},
        "library_scene_count": _scenes.size(),
        "library_quest_count": _quests.size()
    }

    for scene_id in scene_ids:
        var normalized_scene_id := str(scene_id)
        bundle["scene_ids"].append(normalized_scene_id)
        bundle["scenes"][normalized_scene_id] = get_scene(normalized_scene_id)

    for quest_id in quest_ids:
        var normalized_quest_id := str(quest_id)
        bundle["quest_ids"].append(normalized_quest_id)
        bundle["quests"][normalized_quest_id] = get_quest(normalized_quest_id)

    return bundle


func _load_directory(directory: String, target: Dictionary) -> void:
    if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(directory)):
        return

    var files := DirAccess.get_files_at(directory)
    files.sort()

    for file_name in files:
        if not file_name.ends_with(".yaml"):
            continue

        var full_path := "%s/%s" % [directory, file_name]
        var record: Dictionary = EditorialYamlLoaderScript.load_file(full_path)
        var record_id := str(record.get("id", ""))
        if record_id.is_empty():
            continue
        target[record_id] = record


func _discover_data_directories(root_directory: String) -> Array:
    if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(root_directory)):
        return []

    var directories := []
    for directory_name in DirAccess.get_directories_at(root_directory):
        directories.append("%s/%s" % [root_directory, directory_name])
    directories.sort()
    return directories
