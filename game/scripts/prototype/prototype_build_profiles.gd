extends RefCounted

class_name PrototypeBuildProfiles

const PrototypeChapterRegistryScript = preload("res://scripts/prototype/prototype_chapter_registry.gd")

const DEFAULT_PROFILE_ID := "dev_all_content"
const CHAPTER_01_ID := "ch01_falls_to_pandora"
const CHAPTER_02_ID := "ch02_pandora_under_strain"

const PROFILE_DEFS := {
    "dev_all_content": {
        "title": "Dev All Content",
        "chapter_ids": [],
        "review_build": false,
        "allow_manual_debug_maps": true
    },
    "review_slice_ch01": {
        "title": "Review Slice Chapter 1",
        "chapter_ids": [CHAPTER_01_ID],
        "review_build": true,
        "allow_manual_debug_maps": false
    },
    "review_slice_ch01_ch02": {
        "title": "Review Slice Chapter 1-2",
        "chapter_ids": [CHAPTER_01_ID, CHAPTER_02_ID],
        "review_build": true,
        "allow_manual_debug_maps": false
    }
}


static func resolve_runtime_profile() -> Dictionary:
    var profile_id := DEFAULT_PROFILE_ID
    var force_dev_tools := false

    for raw_arg in OS.get_cmdline_user_args():
        var arg := str(raw_arg)
        if arg.begins_with("--build-profile="):
            var candidate_id := arg.trim_prefix("--build-profile=")
            if PROFILE_DEFS.has(candidate_id):
                profile_id = candidate_id
        elif arg == "--dev-tools":
            force_dev_tools = true

    return build_profile(profile_id, force_dev_tools)


static func build_profile(profile_id: String, force_dev_tools: bool = false) -> Dictionary:
    var base_profile: Dictionary = PROFILE_DEFS.get(profile_id, PROFILE_DEFS[DEFAULT_PROFILE_ID])
    var chapter_ids: Array = base_profile.get("chapter_ids", [])
    if chapter_ids.is_empty():
        chapter_ids = PrototypeChapterRegistryScript.get_available_chapter_ids()
    else:
        chapter_ids = chapter_ids.duplicate()

    var manual_debug_map_ids := []
    if bool(base_profile.get("allow_manual_debug_maps", false)) or force_dev_tools:
        manual_debug_map_ids = _build_manual_debug_map_ids(chapter_ids)

    return {
        "id": profile_id,
        "title": str(base_profile.get("title", profile_id)),
        "chapter_ids": chapter_ids,
        "review_build": bool(base_profile.get("review_build", false)),
        "dev_tools_enabled": bool(base_profile.get("allow_manual_debug_maps", false)) or force_dev_tools,
        "manual_debug_map_ids": manual_debug_map_ids
    }


static func _build_manual_debug_map_ids(chapter_ids: Array) -> Array:
    var output := ["test_room", "ch01_character_sandbox"]
    for raw_chapter_id in chapter_ids:
        var chapter_id := str(raw_chapter_id)
        var module = PrototypeChapterRegistryScript.get_module(chapter_id)
        if module == null:
            continue
        for raw_map_id in module.get_debug_map_ids():
            var map_id := str(raw_map_id)
            if output.has(map_id):
                continue
            output.append(map_id)
    return output
