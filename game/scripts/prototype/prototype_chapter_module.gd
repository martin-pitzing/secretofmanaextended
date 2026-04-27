extends RefCounted

class_name PrototypeChapterModule


func get_chapter_id() -> String:
    return ""


func get_scene_to_map_ids() -> Dictionary:
    return {}


func get_debug_map_ids() -> Array:
    return []


func get_expected_completion_trigger_ids() -> Dictionary:
    return {}


func get_expected_quest_completions() -> Dictionary:
    return {}


func get_required_handoff_flags() -> Array:
    return []


func get_story_map_id(scene_id: String) -> String:
    return str(get_scene_to_map_ids().get(scene_id, "test_room"))
