extends RefCounted

class_name ChapterStateStore

const SAVE_DIR := "user://prototype_runtime"


func load_chapter_state(chapter_id: String) -> Dictionary:
    var save_path := _get_save_path(chapter_id)
    if not FileAccess.file_exists(save_path):
        return {}

    var file := FileAccess.open(save_path, FileAccess.READ)
    if file == null:
        return {}

    var parsed = JSON.parse_string(file.get_as_text())
    if parsed is Dictionary:
        return parsed
    return {}


func save_chapter_state(chapter_id: String, state: Dictionary) -> bool:
    _ensure_save_dir()
    var save_path := _get_save_path(chapter_id)
    var file := FileAccess.open(save_path, FileAccess.WRITE)
    if file == null:
        return false

    file.store_string(JSON.stringify(state, "\t"))
    return true


func clear_chapter_state(chapter_id: String) -> void:
    var save_path := _get_save_path(chapter_id)
    if not FileAccess.file_exists(save_path):
        return
    DirAccess.remove_absolute(ProjectSettings.globalize_path(save_path))


func _get_save_path(chapter_id: String) -> String:
    return "%s/%s.json" % [SAVE_DIR, chapter_id]


func _ensure_save_dir() -> void:
    DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(SAVE_DIR))
