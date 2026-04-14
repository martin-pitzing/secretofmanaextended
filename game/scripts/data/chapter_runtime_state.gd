extends RefCounted

class_name ChapterRuntimeState

var _repository
var _chapter := {}
var _chapter_id := ""
var _scene_ids: Array = []
var _quest_ids: Array = []
var _side_quest_ids: Array = []
var _current_scene_index := 0
var _completed_scene_ids: Array = []
var _completed_quest_ids: Array = []
var _active_quest_id := ""
var _flags: Array = []


func configure(repository, chapter_id: String) -> void:
    _repository = repository
    _chapter_id = chapter_id
    _chapter = _repository.get_chapter(chapter_id)
    _scene_ids = _normalize_array(_chapter.get("scene_ids", []))
    _quest_ids = _normalize_array(_chapter.get("quest_ids", []))
    _side_quest_ids = _normalize_array(_chapter.get("side_quest_ids", []))
    restart()


func restart() -> void:
    _current_scene_index = 0
    _completed_scene_ids.clear()
    _completed_quest_ids.clear()
    _flags.clear()
    _active_quest_id = ""
    _refresh_active_quest()


func is_valid() -> bool:
    return not _chapter.is_empty()


func get_chapter_id() -> String:
    return _chapter_id


func get_chapter_record() -> Dictionary:
    return _chapter


func get_current_scene_id() -> String:
    if _scene_ids.is_empty():
        return ""
    var safe_index := clampi(_current_scene_index, 0, _scene_ids.size() - 1)
    return str(_scene_ids[safe_index])


func get_current_scene_record() -> Dictionary:
    return _repository.get_scene(get_current_scene_id())


func get_current_scene_number() -> int:
    return min(_current_scene_index + 1, _scene_ids.size())


func get_total_scene_count() -> int:
    return _scene_ids.size()


func get_active_quest_id() -> String:
    return _active_quest_id


func get_active_quest_record() -> Dictionary:
    if _active_quest_id.is_empty():
        return {}
    return _repository.get_quest(_active_quest_id)


func get_completed_quest_ids() -> Array:
    return _completed_quest_ids.duplicate()


func get_completed_scene_ids() -> Array:
    return _completed_scene_ids.duplicate()


func get_flags() -> Array:
    return _flags.duplicate()


func build_current_bundle() -> Dictionary:
    var scene_ids := []
    var current_scene_id := get_current_scene_id()
    if not current_scene_id.is_empty():
        scene_ids.append(current_scene_id)

    var quest_ids := []
    if not _active_quest_id.is_empty():
        quest_ids.append(_active_quest_id)

    return _repository.build_bundle(scene_ids, quest_ids)


func complete_current_scene() -> Dictionary:
    var result := {
        "scene_id": get_current_scene_id(),
        "scene_flags_added": [],
        "quest_completed_id": "",
        "quest_flags_added": [],
        "new_active_quest_id": "",
        "chapter_complete": false
    }

    var current_scene_id := get_current_scene_id()
    if current_scene_id.is_empty():
        result["chapter_complete"] = true
        return result

    if not _completed_scene_ids.has(current_scene_id):
        _completed_scene_ids.append(current_scene_id)

    var scene_record := get_current_scene_record()
    var scene_flags := _normalize_array(scene_record.get("resulting_flags", []))
    for flag in scene_flags:
        if not _flags.has(flag):
            _flags.append(flag)
            result["scene_flags_added"].append(flag)

    if not _active_quest_id.is_empty():
        var active_quest := get_active_quest_record()
        if _is_quest_complete(active_quest):
            _completed_quest_ids.append(_active_quest_id)
            result["quest_completed_id"] = _active_quest_id

            var quest_flags := _normalize_array(active_quest.get("resulting_flags", []))
            for flag in quest_flags:
                if not _flags.has(flag):
                    _flags.append(flag)
                    result["quest_flags_added"].append(flag)

            _active_quest_id = ""
            _refresh_active_quest()
            result["new_active_quest_id"] = _active_quest_id

    if _current_scene_index < _scene_ids.size() - 1:
        _current_scene_index += 1
    else:
        result["chapter_complete"] = true

    return result


func get_progress_summary() -> Dictionary:
    return {
        "chapter_title": str(_chapter.get("title", _chapter_id)),
        "scene_number": get_current_scene_number(),
        "scene_total": get_total_scene_count(),
        "scene_id": get_current_scene_id(),
        "active_quest_id": _active_quest_id,
        "completed_quest_count": _completed_quest_ids.size(),
        "quest_total": _quest_ids.size(),
        "flag_count": _flags.size(),
        "chapter_complete": _completed_scene_ids.size() >= _scene_ids.size()
    }


func _refresh_active_quest() -> void:
    for quest_id in _quest_ids:
        var normalized := str(quest_id)
        if _completed_quest_ids.has(normalized):
            continue
        _active_quest_id = normalized
        return

    _active_quest_id = ""


func _is_quest_complete(quest_record: Dictionary) -> bool:
    var related_scene_ids := _normalize_array(quest_record.get("related_scene_ids", []))
    if related_scene_ids.is_empty():
        return false

    for scene_id in related_scene_ids:
        if not _completed_scene_ids.has(scene_id):
            return false
    return true


func _normalize_array(values) -> Array:
    if values is PackedStringArray:
        return Array(values)
    if values is Array:
        var normalized := []
        for value in values:
            normalized.append(str(value))
        return normalized
    return []
