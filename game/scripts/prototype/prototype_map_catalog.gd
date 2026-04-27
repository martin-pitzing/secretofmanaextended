extends RefCounted

class_name PrototypeMapCatalog

const ORDERED_MAP_IDS := [
    "test_room",
    "water_palace_inner_chamber",
    "forbidden_falls",
    "pandora_gate_district",
    "pandora_court_route",
    "pandora_annex_route",
    "potos_story_stage",
    "exile_road_stage",
    "water_palace_approach_stage",
    "road_to_pandora_stage"
]

const MAPS_BY_ID := {
    "test_room": {
        "title": "Test Hall",
        "scene": preload("res://scenes/prototype/maps/test_room.tscn"),
        "dev_only": true
    },
    "water_palace_inner_chamber": {
        "title": "Water Palace",
        "scene": preload("res://scenes/prototype/maps/water_palace_benchmark.tscn")
    },
    "forbidden_falls": {
        "title": "Forbidden Falls",
        "scene": preload("res://scenes/prototype/maps/forbidden_falls_benchmark.tscn")
    },
    "pandora_gate_district": {
        "title": "Pandora Gate District",
        "scene": preload("res://scenes/prototype/maps/pandora_district_benchmark.tscn")
    },
    "pandora_court_route": {
        "title": "Pandora Court Route",
        "scene": preload("res://scenes/prototype/maps/pandora_court_route_benchmark.tscn")
    },
    "pandora_annex_route": {
        "title": "Pandora Annex Route",
        "scene": preload("res://scenes/prototype/maps/pandora_annex_route_benchmark.tscn")
    },
    "potos_story_stage": {
        "title": "Potos Story Stage",
        "scene": preload("res://scenes/prototype/maps/potos_story_stage.tscn")
    },
    "exile_road_stage": {
        "title": "Exile Road Stage",
        "scene": preload("res://scenes/prototype/maps/exile_road_stage.tscn")
    },
    "water_palace_approach_stage": {
        "title": "Water Palace Approach Stage",
        "scene": preload("res://scenes/prototype/maps/water_palace_approach_stage.tscn")
    },
    "road_to_pandora_stage": {
        "title": "Road To Pandora Stage",
        "scene": preload("res://scenes/prototype/maps/road_to_pandora_stage.tscn")
    }
}


static func get_ordered_map_ids() -> Array:
    return ORDERED_MAP_IDS.duplicate()


static func has_map(map_id: String) -> bool:
    return MAPS_BY_ID.has(map_id)


static func get_map_record(map_id: String) -> Dictionary:
    var record: Dictionary = MAPS_BY_ID.get(map_id, {})
    if record.is_empty():
        return {}

    var normalized := record.duplicate(true)
    normalized["map_id"] = map_id
    return normalized


static func get_map_title(map_id: String) -> String:
    var record: Dictionary = MAPS_BY_ID.get(map_id, {})
    return str(record.get("title", map_id))


static func get_map_scene(map_id: String):
    var record: Dictionary = MAPS_BY_ID.get(map_id, {})
    return record.get("scene")


static func build_records(map_ids: Array) -> Array:
    var records := []
    for raw_map_id in map_ids:
        var map_id := str(raw_map_id)
        if not MAPS_BY_ID.has(map_id):
            continue
        records.append(get_map_record(map_id))
    return records
