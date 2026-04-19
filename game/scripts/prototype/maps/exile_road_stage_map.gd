extends "res://scripts/prototype/prototype_map.gd"

const Chapter1MapPrimitives = preload("res://scripts/prototype/maps/chapter1_map_primitives.gd")

var _palette := {
    "background": Color(0.0627451, 0.0901961, 0.0941176, 1),
    "wall": Color(0.14902, 0.180392, 0.145098, 1),
    "wall_outline": Color(0.294118, 0.352941, 0.27451, 1),
    "path": Color(0.360784, 0.333333, 0.247059, 1),
    "wet_ground": Color(0.286275, 0.321569, 0.235294, 1),
    "boundary_stone": Color(0.560784, 0.541176, 0.45098, 1),
    "rope": Color(0.690196, 0.596078, 0.396078, 1),
    "post": Color(0.447059, 0.32549, 0.215686, 1),
    "brush": Color(0.282353, 0.423529, 0.278431, 1),
    "fire_glow": Color(0.968627, 0.733333, 0.447059, 0.16),
    "ward_glow": Color(0.67451, 0.85098, 0.901961, 0.16),
    "trigger_marker": Color(0.890196, 0.780392, 0.505882, 0.95),
    "trigger_warning": Color(0.678431, 0.835294, 0.898039, 0.95),
    "trigger_route": Color(0.960784, 0.835294, 0.521569, 0.95),
    "enemy_1": Color(0.807843, 0.505882, 0.345098, 1),
    "enemy_2": Color(0.898039, 0.584314, 0.376471, 1)
}


func get_map_id() -> String:
    return "exile_road_stage"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Exile Road Stage"
    return "%s Stage" % scene.get("title", "Exile Road Stage")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "forest path beyond Potos"))
    if get_active_enemy_count() > 0:
        return "%s | Pressure active in %s." % [quest_title, location]
    return "%s | %s." % [quest_title, location]


func get_status_text() -> String:
    if get_active_enemy_count() > 0:
        return "Exile pressure active: %d hostile echoes." % get_active_enemy_count()
    return get_map_subtitle()


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 736, 432)


func get_spawn_position() -> Vector2:
    return Vector2(112, 322)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        Chapter1MapPrimitives.rect_fill(Rect2(44, 44, 648, 344), _palette["wet_ground"]),
        Chapter1MapPrimitives.rect_fill(Rect2(78, 94, 566, 228), _palette["path"]),
        Chapter1MapPrimitives.rect_fill(Rect2(78, 94, 122, 96), _palette["boundary_stone"]),
        Chapter1MapPrimitives.rect_fill(Rect2(520, 104, 106, 92), _palette["wet_ground"]),
        Chapter1MapPrimitives.rect_fill(Rect2(150, 338, 438, 16), _palette["post"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(126, 126, 18, 64), _palette["post"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(170, 126, 18, 64), _palette["post"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(544, 126, 18, 58), _palette["post"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(592, 126, 18, 58), _palette["post"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(236, 128, 116, 34), _palette["boundary_stone"], 2.0))
    overlays.append_array(Chapter1MapPrimitives.crate_cluster([
        Rect2(250, 244, 34, 18),
        Rect2(292, 244, 28, 22),
        Rect2(334, 252, 24, 16)
    ], _palette["post"], _palette["wall"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(450, 234, 34, 28), _palette["brush"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(496, 228, 26, 34), _palette["brush"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(566, 234, 38, 30), _palette["boundary_stone"], 2.0))
    return overlays


func get_circle_draws() -> Array:
    return [
        Chapter1MapPrimitives.circle_draw(Vector2(158, 158), 18.0, _palette["ward_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(332, 252), 16.0, _palette["fire_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(584, 250), 18.0, _palette["ward_glow"])
    ]


func get_line_draws() -> Array:
    return [
        Chapter1MapPrimitives.line_draw(Vector2(144, 156), Vector2(184, 156), _palette["rope"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(222, 124), Vector2(446, 124), _palette["rope"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(114, 344), Vector2(620, 344), _palette["rope"], 3.0)
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(44, 44, 648, 18),
        Rect2(44, 370, 648, 18),
        Rect2(44, 62, 18, 308),
        Rect2(674, 62, 18, 308),
        Rect2(78, 94, 122, 18),
        Rect2(78, 112, 18, 84),
        Rect2(182, 112, 18, 84),
        Rect2(78, 178, 30, 18),
        Rect2(140, 178, 60, 18),
        Rect2(520, 104, 106, 18),
        Rect2(520, 122, 18, 78),
        Rect2(608, 122, 18, 78),
        Rect2(520, 182, 32, 18),
        Rect2(576, 182, 50, 18),
        Rect2(426, 226, 18, 54),
        Rect2(478, 226, 18, 54)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Push forward beyond the village boundary."))

    return [
        {
            "id": "boundary_marker",
            "speaker": "Boundary Ward",
            "prompt": "read the severed ward",
            "radius": 18.0,
            "position": Vector2(158, 156),
            "color": _palette["trigger_warning"],
            "lines": PackedStringArray([
                "Exile becomes practical abandonment here, not symbolic punishment.",
                "The same village that kept old warnings alive now uses them to define who stays protected."
            ])
        },
        {
            "id": "escort_break",
            "speaker": "Retreating Escort",
            "prompt": "watch the escort turn back",
            "radius": 18.0,
            "position": Vector2(334, 250),
            "color": _palette["trigger_marker"],
            "lines": PackedStringArray(scene_info_lines)
        },
        {
            "id": "forward_road",
            "speaker": "Forest Route Marker",
            "prompt": "push deeper into exile",
            "radius": 22.0,
            "position": Vector2(584, 250),
            "color": _palette["trigger_route"],
            "completes_scene": true,
            "requires_enemy_clear": true,
            "blocked_status": "The route is still unsafe while the nearby echoes are active.",
            "blocked_lines": [
                "The road out is still contested.",
                "Break the immediate pressure before leaving Potos fully behind."
            ],
            "completion_status": "The exile road is clear enough to carry the chapter forward.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The village boundary now reads as a true loss of protection instead of a simple chapter transition."
            ]
        }
    ]


func get_enemy_specs() -> Array:
    return [
        {
            "position": Vector2(456, 238),
            "color": _palette["enemy_1"],
            "move_speed": 30.0,
            "idle_radius": 12.0,
            "aggro_radius": 106.0,
            "hit_points": 2
        },
        {
            "position": Vector2(548, 276),
            "color": _palette["enemy_2"],
            "move_speed": 32.0,
            "idle_radius": 10.0,
            "aggro_radius": 106.0,
            "hit_points": 2
        }
    ]
