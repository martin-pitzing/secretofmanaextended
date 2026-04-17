extends RefCounted

class_name ChapterStateStore

const SAVE_DIR := "user://prototype_runtime"
const CAMPAIGN_STATE_PATH := "%s/campaign.json" % SAVE_DIR


func load_chapter_state(chapter_id: String) -> Dictionary:
    return _load_json(_get_save_path(chapter_id))


func save_chapter_state(chapter_id: String, state: Dictionary) -> bool:
    return _save_json(_get_save_path(chapter_id), state)


func clear_chapter_state(chapter_id: String) -> void:
    _remove_path(_get_save_path(chapter_id))


func load_campaign_state() -> Dictionary:
    return _load_json(CAMPAIGN_STATE_PATH)


func save_campaign_state(state: Dictionary) -> bool:
    return _save_json(CAMPAIGN_STATE_PATH, state)


func clear_campaign_state() -> void:
    _remove_path(CAMPAIGN_STATE_PATH)


func clear_all_runtime_state(chapter_ids: Array) -> void:
    clear_campaign_state()
    for chapter_id in chapter_ids:
        clear_chapter_state(str(chapter_id))


func _get_save_path(chapter_id: String) -> String:
    return "%s/%s.json" % [SAVE_DIR, chapter_id]


func _ensure_save_dir() -> void:
    DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(SAVE_DIR))


func _load_json(path: String) -> Dictionary:
    if not FileAccess.file_exists(path):
        return {}

    var file := FileAccess.open(path, FileAccess.READ)
    if file == null:
        return {}

    var parsed = JSON.parse_string(file.get_as_text())
    if parsed is Dictionary:
        return parsed
    return {}


func _save_json(path: String, state: Dictionary) -> bool:
    _ensure_save_dir()
    var file := FileAccess.open(path, FileAccess.WRITE)
    if file == null:
        return false

    file.store_string(JSON.stringify(state, "\t"))
    return true


func _remove_path(path: String) -> void:
    if not FileAccess.file_exists(path):
        return
    DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
