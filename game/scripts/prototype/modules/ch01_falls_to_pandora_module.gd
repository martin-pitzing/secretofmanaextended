extends "res://scripts/prototype/prototype_chapter_module.gd"

const CHAPTER_ID := "ch01_falls_to_pandora"
const SCENE_TO_MAP_IDS := {
    "ch01_sc01_potos_morning": "potos_story_stage",
    "ch01_sc02_forbidden_falls": "forbidden_falls",
    "ch01_sc03_judgment_at_potos": "potos_story_stage",
    "ch01_sc04_exile_procession": "exile_road_stage",
    "ch01_sc05_water_palace_approach": "water_palace_approach_stage",
    "ch01_sc06_luka_charge": "water_palace_inner_chamber",
    "ch01_sc07_road_to_pandora": "road_to_pandora_stage",
    "ch01_sc08_pandora_gate_district": "pandora_gate_district"
}
const DEBUG_MAP_IDS := [
    "potos_story_stage",
    "forbidden_falls",
    "exile_road_stage",
    "water_palace_approach_stage",
    "water_palace_inner_chamber",
    "road_to_pandora_stage",
    "pandora_gate_district"
]
const EXPECTED_COMPLETION_TRIGGER_IDS := {
    "ch01_sc01_potos_morning": "boys_route",
    "ch01_sc02_forbidden_falls": "altar_read",
    "ch01_sc03_judgment_at_potos": "judgment_ring",
    "ch01_sc04_exile_procession": "forward_road",
    "ch01_sc05_water_palace_approach": "entry_gate",
    "ch01_sc06_luka_charge": "ritual_basin",
    "ch01_sc07_road_to_pandora": "pandora_marker",
    "ch01_sc08_pandora_gate_district": "inn_shelter"
}
const EXPECTED_QUEST_COMPLETIONS := {
    "ch01_sc02_forbidden_falls": "q_ch01_001_leave_potos",
    "ch01_sc04_exile_procession": "q_ch01_002_accept_exile",
    "ch01_sc06_luka_charge": "q_ch01_003_seek_water_palace",
    "ch01_sc08_pandora_gate_district": "q_ch01_004_witness_pandora_strain"
}


func get_chapter_id() -> String:
    return CHAPTER_ID


func get_scene_to_map_ids() -> Dictionary:
    return SCENE_TO_MAP_IDS


func get_debug_map_ids() -> Array:
    return DEBUG_MAP_IDS.duplicate()


func get_expected_completion_trigger_ids() -> Dictionary:
    return EXPECTED_COMPLETION_TRIGGER_IDS


func get_expected_quest_completions() -> Dictionary:
    return EXPECTED_QUEST_COMPLETIONS
