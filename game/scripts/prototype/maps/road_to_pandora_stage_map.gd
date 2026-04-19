extends "res://scripts/prototype/prototype_map.gd"

const Chapter1MapPrimitives = preload("res://scripts/prototype/maps/chapter1_map_primitives.gd")

var _palette := {
    "background": Color(0.0843137, 0.109804, 0.121569, 1),
    "wall": Color(0.203922, 0.196078, 0.172549, 1),
    "wall_outline": Color(0.392157, 0.372549, 0.321569, 1),
    "road": Color(0.494118, 0.435294, 0.317647, 1),
    "grass": Color(0.341176, 0.423529, 0.266667, 1),
    "camp": Color(0.635294, 0.560784, 0.427451, 1),
    "wagon": Color(0.447059, 0.32549, 0.219608, 1),
    "canvas": Color(0.760784, 0.721569, 0.596078, 1),
    "ledger": Color(0.796078, 0.768627, 0.611765, 1),
    "horizon": Color(0.607843, 0.423529, 0.333333, 1),
    "route_glow": Color(0.929412, 0.784314, 0.556863, 0.16),
    "camp_glow": Color(0.956863, 0.717647, 0.454902, 0.14),
    "trigger_notice": Color(0.670588, 0.819608, 0.913725, 0.95),
    "trigger_travel": Color(0.921569, 0.780392, 0.505882, 0.95),
    "trigger_gate": Color(0.972549, 0.839216, 0.52549, 0.95)
}


func get_map_id() -> String:
    return "road_to_pandora_stage"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Road To Pandora Stage"
    return "%s Stage" % scene.get("title", "Road To Pandora Stage")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "route between Water Palace and Pandora outskirts"))
    return "%s | %s." % [quest_title, location]


func get_status_text() -> String:
    return "Regional strain is visible all the way to Pandora's outskirts."


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 736, 432)


func get_spawn_position() -> Vector2:
    return Vector2(118, 316)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        Chapter1MapPrimitives.rect_fill(Rect2(42, 44, 652, 344), _palette["grass"]),
        Chapter1MapPrimitives.rect_fill(Rect2(78, 112, 552, 204), _palette["road"]),
        Chapter1MapPrimitives.rect_fill(Rect2(86, 90, 118, 92), _palette["camp"]),
        Chapter1MapPrimitives.rect_fill(Rect2(256, 96, 140, 104), _palette["camp"]),
        Chapter1MapPrimitives.rect_fill(Rect2(474, 90, 134, 108), _palette["horizon"]),
        Chapter1MapPrimitives.rect_fill(Rect2(120, 338, 478, 16), _palette["wagon"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(104, 104, 48, 44), _palette["canvas"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(158, 118, 22, 28), _palette["wagon"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(276, 112, 86, 34), _palette["ledger"], 2.0))
    overlays.append_array(Chapter1MapPrimitives.crate_cluster([
        Rect2(282, 246, 36, 18),
        Rect2(326, 246, 30, 22),
        Rect2(364, 254, 24, 16)
    ], _palette["wagon"], _palette["wall"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(506, 112, 70, 36), _palette["canvas"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(532, 214, 24, 34), _palette["wagon"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(558, 236, 36, 26), _palette["ledger"], 2.0))
    return overlays


func get_circle_draws() -> Array:
    return [
        Chapter1MapPrimitives.circle_draw(Vector2(142, 140), 18.0, _palette["camp_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(338, 250), 16.0, _palette["route_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(558, 140), 20.0, Color(0.866667, 0.705882, 0.552941, 0.16))
    ]


func get_line_draws() -> Array:
    return [
        Chapter1MapPrimitives.line_draw(Vector2(90, 204), Vector2(618, 204), _palette["ledger"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(128, 344), Vector2(600, 344), _palette["ledger"], 3.0),
        Chapter1MapPrimitives.line_draw(Vector2(434, 116), Vector2(608, 116), _palette["ledger"], 2.0)
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(42, 44, 652, 18),
        Rect2(42, 370, 652, 18),
        Rect2(42, 62, 18, 308),
        Rect2(676, 62, 18, 308),
        Rect2(86, 90, 118, 18),
        Rect2(86, 108, 18, 74),
        Rect2(186, 108, 18, 74),
        Rect2(256, 96, 140, 18),
        Rect2(256, 114, 18, 90),
        Rect2(378, 114, 18, 90),
        Rect2(474, 90, 134, 18),
        Rect2(474, 108, 18, 94),
        Rect2(590, 108, 18, 94),
        Rect2(514, 228, 18, 42),
        Rect2(550, 228, 18, 42)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Reach Pandora's gate district."))

    return [
        {
            "id": "route_ledger",
            "speaker": "Warning Ledger",
            "prompt": "inspect the route ledger",
            "radius": 18.0,
            "position": Vector2(338, 248),
            "color": _palette["trigger_notice"],
            "lines": PackedStringArray([
                "Road traffic now carries rumors, shortages, and signs that the crisis is regional rather than local.",
                "A route ledger is more useful than a speech here because it turns fear into evidence."
            ])
        },
        {
            "id": "traveler_cluster",
            "speaker": "Displaced Travelers",
            "prompt": "hear the road gossip",
            "radius": 18.0,
            "position": Vector2(142, 140),
            "color": _palette["trigger_travel"],
            "lines": PackedStringArray(scene_info_lines)
        },
        {
            "id": "pandora_marker",
            "speaker": "Pandora Road Marker",
            "prompt": "follow the road to Pandora",
            "radius": 20.0,
            "position": Vector2(558, 140),
            "color": _palette["trigger_gate"],
            "completes_scene": true,
            "completion_status": "Pandora now sits close enough to define the route ahead.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The road should feel like one long approach into civic strain rather than an empty travel screen."
            ]
        }
    ]
