extends "res://scripts/prototype/prototype_map.gd"

const Chapter1MapPrimitives = preload("res://scripts/prototype/maps/chapter1_map_primitives.gd")

var _palette := {
    "background": Color(0.0470588, 0.0901961, 0.12549, 1),
    "wall": Color(0.129412, 0.180392, 0.219608, 1),
    "wall_outline": Color(0.270588, 0.388235, 0.439216, 1),
    "causeway": Color(0.694118, 0.764706, 0.784314, 1),
    "terrace": Color(0.819608, 0.878431, 0.886275, 1),
    "water": Color(0.313726, 0.560784, 0.666667, 1),
    "water_glow": Color(0.760784, 0.937255, 0.972549, 0.2),
    "gold": Color(0.878431, 0.784314, 0.529412, 1),
    "archive_case": Color(0.576471, 0.631373, 0.654902, 1),
    "mat": Color(0.701961, 0.756863, 0.666667, 1),
    "satchel": Color(0.521569, 0.368627, 0.243137, 1),
    "trigger_entry": Color(0.956863, 0.847059, 0.560784, 0.95),
    "trigger_archive": Color(0.623529, 0.803922, 0.898039, 0.95),
    "trigger_attendant": Color(0.858824, 0.901961, 0.682353, 0.95)
}


func get_map_id() -> String:
    return "water_palace_approach_stage"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Water Palace Approach Stage"
    return "%s Stage" % scene.get("title", "Water Palace Approach Stage")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "river route and palace exterior grounds"))
    return "%s | %s." % [quest_title, location]


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 704, 416)


func get_spawn_position() -> Vector2:
    return Vector2(112, 300)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        Chapter1MapPrimitives.rect_fill(Rect2(44, 44, 616, 328), _palette["causeway"]),
        Chapter1MapPrimitives.rect_fill(Rect2(74, 78, 224, 242), _palette["water"]),
        Chapter1MapPrimitives.rect_fill(Rect2(314, 78, 314, 242), _palette["terrace"]),
        Chapter1MapPrimitives.rect_fill(Rect2(314, 96, 164, 78), _palette["causeway"]),
        Chapter1MapPrimitives.rect_fill(Rect2(498, 96, 100, 98), _palette["causeway"]),
        Chapter1MapPrimitives.rect_fill(Rect2(116, 336, 468, 16), _palette["gold"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(132, 112, 108, 172), _palette["water"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(350, 118, 90, 28), _palette["gold"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(364, 162, 64, 26), _palette["mat"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(520, 118, 48, 74), _palette["archive_case"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(534, 214, 22, 24), _palette["satchel"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(518, 244, 54, 30), _palette["gold"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(430, 246, 24, 30), _palette["archive_case"]))
    return overlays


func get_circle_draws() -> Array:
    return [
        Chapter1MapPrimitives.circle_draw(Vector2(184, 200), 24.0, _palette["water_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(396, 132), 16.0, Color(0.933333, 0.886275, 0.682353, 0.18)),
        Chapter1MapPrimitives.circle_draw(Vector2(544, 162), 18.0, Color(0.760784, 0.937255, 0.972549, 0.16))
    ]


func get_line_draws() -> Array:
    return [
        Chapter1MapPrimitives.line_draw(Vector2(298, 92), Vector2(298, 320), _palette["gold"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(332, 206), Vector2(606, 206), _palette["gold"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(120, 344), Vector2(584, 344), _palette["gold"], 3.0)
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(44, 44, 616, 18),
        Rect2(44, 354, 616, 18),
        Rect2(44, 62, 18, 292),
        Rect2(642, 62, 18, 292),
        Rect2(314, 78, 314, 18),
        Rect2(314, 96, 18, 224),
        Rect2(610, 96, 18, 224),
        Rect2(314, 302, 118, 18),
        Rect2(468, 302, 160, 18),
        Rect2(518, 118, 18, 74),
        Rect2(552, 118, 18, 74)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Gain entry to Luka's chamber."))

    return [
        {
            "id": "attendant_queue",
            "speaker": "Palace Attendant",
            "prompt": "request an audience",
            "radius": 18.0,
            "position": Vector2(396, 132),
            "color": _palette["trigger_attendant"],
            "lines": PackedStringArray([
                "The Water Palace grounds should feel organized before they feel comforting.",
                "Attendants, mats, and route markers make the palace read like a functioning institution, not just a holy backdrop."
            ])
        },
        {
            "id": "archive_pocket",
            "speaker": "Archivist Neral",
            "prompt": "inspect the archive route",
            "radius": 18.0,
            "position": Vector2(544, 160),
            "color": _palette["trigger_archive"],
            "lines": PackedStringArray(scene_info_lines)
        },
        {
            "id": "entry_gate",
            "speaker": "Inner Causeway",
            "prompt": "enter Luka's chamber",
            "radius": 20.0,
            "position": Vector2(446, 256),
            "color": _palette["trigger_entry"],
            "completes_scene": true,
            "completion_status": "The Water Palace now opens inward toward Luka's audience chamber.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The approach should already communicate that this temple manages routes, records, and access before Luka speaks a word."
            ]
        }
    ]
