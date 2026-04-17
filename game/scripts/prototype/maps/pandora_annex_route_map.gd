extends "res://scripts/prototype/prototype_map.gd"

const PandoraMapPrimitives = preload("res://scripts/prototype/maps/pandora_map_primitives.gd")

var _palette := PandoraMapPrimitives.annex_palette()


func get_map_id() -> String:
    return "pandora_annex_route"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Pandora Annex Route"
    return "%s Benchmark" % scene.get("title", "Pandora Annex Route")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "Pandora annex route"))
    if get_active_enemy_count() > 0:
        return "%s | Pressure active in %s." % [quest_title, location]
    return "%s | %s." % [quest_title, location]


func get_status_text() -> String:
    if get_active_enemy_count() > 0:
        return "Annex pressure active: %d hostile echoes." % get_active_enemy_count()
    return get_map_subtitle()


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 736, 432)


func get_spawn_position() -> Vector2:
    match get_primary_scene_id():
        "ch02_sc06_kroll_offer":
            return Vector2(354, 262)
        "ch02_sc07_mission_ledger":
            return Vector2(576, 314)
        "ch02_sc08_departure_lower_gate":
            return Vector2(144, 340)
        _:
            return Vector2(354, 262)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(42, 44, 652, 344), "color": Color(0.509804, 0.494118, 0.454902, 1)},
        {"rect": Rect2(86, 74, 252, 122), "color": Color(0.611765, 0.580392, 0.470588, 1)},
        {"rect": Rect2(362, 74, 252, 122), "color": Color(0.588235, 0.560784, 0.490196, 1)},
        {"rect": Rect2(94, 226, 228, 118), "color": Color(0.572549, 0.541176, 0.47451, 1)},
        {"rect": Rect2(392, 220, 244, 132), "color": Color(0.47451, 0.447059, 0.403922, 1)},
        {"rect": Rect2(118, 360, 202, 16), "color": Color(0.388235, 0.317647, 0.203922, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(372, 100, 104, 54), "color": Color(0.741176, 0.603922, 0.333333, 1)},
        {"rect": Rect2(488, 100, 82, 54), "color": Color(0.721569, 0.701961, 0.647059, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(450, 250, 88, 66), "color": Color(0.682353, 0.643137, 0.529412, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(154, 252, 110, 34), "color": Color(0.780392, 0.733333, 0.545098, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(130, 98, 132, 18), "color": Color(0.768627, 0.631373, 0.392157, 1)}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(420, 144), "radius": 20.0, "color": Color(0.952941, 0.713725, 0.482353, 0.18)},
        {"position": Vector2(516, 278), "radius": 18.0, "color": Color(0.639216, 0.764706, 0.905882, 0.18)},
        {"position": Vector2(196, 270), "radius": 18.0, "color": Color(0.921569, 0.823529, 0.584314, 0.14)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(350, 80), "to": Vector2(350, 372), "color": Color(0.309804, 0.32549, 0.364706, 1), "width": 2.0},
        {"from": Vector2(84, 212), "to": Vector2(644, 212), "color": Color(0.309804, 0.32549, 0.364706, 1), "width": 2.0},
        {"from": Vector2(114, 352), "to": Vector2(318, 352), "color": Color(0.423529, 0.337255, 0.227451, 1), "width": 3.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(42, 44, 652, 18),
        Rect2(42, 370, 652, 18),
        Rect2(42, 62, 18, 308),
        Rect2(676, 62, 18, 308),
        Rect2(340, 74, 18, 284),
        Rect2(60, 204, 280, 18),
        Rect2(358, 204, 318, 18),
        Rect2(318, 352, 40, 18)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Advance through the annex and lower-gate route."))

    return [
        {
            "id": "kroll_dais",
            "speaker": "Imperial Receiving Dais",
            "prompt": "watch Kroll's address",
            "radius": 22.0,
            "position": Vector2(420, 142),
            "color": Color(0.972549, 0.701961, 0.478431, 0.95),
            "lines": PackedStringArray([
                "The dais is built to make coercion sound like administration.",
                "Crowd choreography matters here: the Empire wants to be seen as inevitable, not brutal."
            ]),
            "completes_scene": scene_id == "ch02_sc06_kroll_offer",
            "completion_status": "Kroll's intervention has been fully witnessed.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "Pandora's crisis now has an explicit imperial face."
            ]
        },
        {
            "id": "ledger_annex",
            "speaker": "Archive Annex",
            "prompt": "search the annex ledger",
            "radius": 20.0,
            "position": Vector2(504, 278),
            "color": Color(0.654902, 0.780392, 0.92549, 0.95),
            "lines": PackedStringArray([
                "Storage, archives, and relief offices share the same corridor language because someone wanted deniability.",
                "This is where political sacrifice gets written down as logistics."
            ]),
            "completes_scene": scene_id == "ch02_sc07_mission_ledger",
            "requires_enemy_clear": true,
            "blocked_status": "The annex is still too hot to search cleanly.",
            "blocked_lines": [
                "Guards are still pressing the annex route.",
                "Break the immediate pressure before taking the ledger."
            ],
            "completion_status": "The ledger fragment is secured and the escape route is open.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The recovered fragment turns political suspicion into documentary proof."
            ]
        },
        {
            "id": "lower_gate",
            "speaker": "Lower Gate Marker",
            "prompt": "leave through the lower gate",
            "radius": 22.0,
            "position": Vector2(198, 352),
            "color": Color(0.952941, 0.843137, 0.545098, 0.95),
            "lines": PackedStringArray([
                "The lower gate blends civilians, relief wagons, and militia remnants into one outbound pressure valve.",
                "Leaving here feels chosen instead of accidental."
            ]),
            "completes_scene": scene_id == "ch02_sc08_departure_lower_gate",
            "completion_status": "Pandora is behind you and the outbound route is now the active thread.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The chapter closes on departure with purpose rather than drift."
            ]
        },
        {
            "id": "annex_echo",
            "speaker": "Annex Route Echo",
            "prompt": "read the route pressure",
            "radius": 18.0,
            "position": Vector2(210, 266),
            "color": Color(0.611765, 0.717647, 0.85098, 0.95),
            "lines": PackedStringArray(scene_info_lines)
        }
    ]


func get_enemy_specs() -> Array:
    if get_primary_scene_id() != "ch02_sc07_mission_ledger":
        return []

    return [
        {
            "position": Vector2(468, 266),
            "color": Color(0.831373, 0.505882, 0.337255, 1),
            "move_speed": 33.0,
            "idle_radius": 14.0,
            "aggro_radius": 112.0,
            "hit_points": 2
        },
        {
            "position": Vector2(584, 318),
            "color": Color(0.905882, 0.580392, 0.372549, 1),
            "move_speed": 35.0,
            "idle_radius": 12.0,
            "aggro_radius": 112.0,
            "hit_points": 2
        }
    ]
