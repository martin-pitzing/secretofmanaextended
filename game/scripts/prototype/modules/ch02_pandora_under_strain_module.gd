extends "res://scripts/prototype/prototype_chapter_module.gd"

const CHAPTER_ID := "ch02_pandora_under_strain"
const SCENE_TO_MAP_IDS := {
    "ch02_sc01_gate_district_morning_after": "pandora_gate_district",
    "ch02_sc02_rumors_of_dyluck": "pandora_gate_district",
    "ch02_sc03_court_wall_garden_breach": "pandora_court_route",
    "ch02_sc04_terms_of_alliance": "pandora_court_route",
    "ch02_sc05_pandora_court_divides": "pandora_court_route",
    "ch02_sc06_kroll_offer": "pandora_annex_route",
    "ch02_sc07_mission_ledger": "pandora_annex_route",
    "ch02_sc08_departure_lower_gate": "pandora_annex_route"
}
const DEBUG_MAP_IDS := [
    "pandora_gate_district",
    "pandora_court_route",
    "pandora_annex_route"
]
const EXPECTED_COMPLETION_TRIGGER_IDS := {
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
const REQUIRED_HANDOFF_FLAGS := [
    "flag_region_pandora_entered",
    "flag_faction_pandora_instability_visible",
    "flag_faction_water_palace_contact_established"
]


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


func get_required_handoff_flags() -> Array:
    return REQUIRED_HANDOFF_FLAGS.duplicate()
