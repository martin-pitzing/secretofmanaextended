extends "res://scripts/prototype/prototype_map.gd"


func get_map_id() -> String:
    return "pandora_court_route"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Pandora Court Route"
    return "%s Benchmark" % scene.get("title", "Pandora Court Route")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "Pandora court route"))
    if get_active_enemy_count() > 0:
        return "%s | Pressure active in %s." % [quest_title, location]
    return "%s | %s." % [quest_title, location]


func get_status_text() -> String:
    if get_active_enemy_count() > 0:
        return "Pursuit pressure active: %d hostile echoes." % get_active_enemy_count()
    return get_map_subtitle()


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 704, 416)


func get_spawn_position() -> Vector2:
    match get_primary_scene_id():
        "ch02_sc03_court_wall_garden_breach":
            return Vector2(560, 296)
        "ch02_sc04_terms_of_alliance":
            return Vector2(154, 126)
        "ch02_sc05_pandora_court_divides":
            return Vector2(398, 110)
        _:
            return Vector2(154, 126)


func get_background_color() -> Color:
    return Color(0.0666667, 0.0745098, 0.0941176, 1)


func get_wall_color() -> Color:
    return Color(0.203922, 0.215686, 0.239216, 1)


func get_wall_outline_color() -> Color:
    return Color(0.34902, 0.364706, 0.4, 1)


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(42, 42, 620, 330), "color": Color(0.513725, 0.509804, 0.47451, 1)},
        {"rect": Rect2(78, 78, 206, 102), "color": Color(0.639216, 0.603922, 0.490196, 1)},
        {"rect": Rect2(332, 74, 274, 118), "color": Color(0.576471, 0.556863, 0.505882, 1)},
        {"rect": Rect2(110, 210, 186, 112), "color": Color(0.454902, 0.45098, 0.419608, 1)},
        {"rect": Rect2(350, 224, 258, 118), "color": Color(0.533333, 0.521569, 0.47451, 1)},
        {"rect": Rect2(520, 88, 68, 94), "color": Color(0.431373, 0.541176, 0.419608, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(106, 104, 118, 42), "color": Color(0.803922, 0.752941, 0.556863, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(390, 96, 88, 54), "color": Color(0.721569, 0.611765, 0.352941, 1)},
        {"rect": Rect2(538, 102, 30, 66), "color": Color(0.768627, 0.839216, 0.623529, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(138, 236, 104, 34), "color": Color(0.776471, 0.721569, 0.537255, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(432, 252, 76, 62), "color": Color(0.678431, 0.635294, 0.521569, 1), "filled": false, "width": 2.0}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(540, 138), "radius": 18.0, "color": Color(0.678431, 0.870588, 0.627451, 0.2)},
        {"position": Vector2(178, 254), "radius": 18.0, "color": Color(0.858824, 0.784314, 0.552941, 0.16)},
        {"position": Vector2(462, 282), "radius": 16.0, "color": Color(0.917647, 0.815686, 0.588235, 0.16)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(314, 80), "to": Vector2(314, 356), "color": Color(0.305882, 0.329412, 0.364706, 1), "width": 2.0},
        {"from": Vector2(94, 198), "to": Vector2(610, 198), "color": Color(0.305882, 0.329412, 0.364706, 1), "width": 2.0},
        {"from": Vector2(504, 94), "to": Vector2(596, 178), "color": Color(0.478431, 0.658824, 0.466667, 0.65), "width": 3.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(42, 42, 620, 18),
        Rect2(42, 354, 620, 18),
        Rect2(42, 60, 18, 294),
        Rect2(644, 60, 18, 294),
        Rect2(296, 74, 18, 260),
        Rect2(60, 190, 236, 18),
        Rect2(314, 190, 330, 18),
        Rect2(502, 74, 18, 84)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Advance through the court route."))

    return [
        {
            "id": "garden_gap",
            "speaker": "Service Gate Breach",
            "prompt": "slip through the garden breach",
            "radius": 20.0,
            "position": Vector2(540, 138),
            "color": Color(0.65098, 0.878431, 0.611765, 0.95),
            "lines": PackedStringArray([
                "The wall divide between court and service routes is visible in the map itself.",
                "Primm's escape path runs through spaces meant for servants, not nobles."
            ]),
            "completes_scene": scene_id == "ch02_sc03_court_wall_garden_breach",
            "requires_enemy_clear": true,
            "blocked_status": "The breach route is still watched by hostile pursuit.",
            "blocked_lines": [
                "The service gap is not safe yet.",
                "Shake the nearby pursuit before slipping Primm through the breach."
            ],
            "completion_status": "The garden breach is clear enough to reach temporary cover.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "This scene resolves once the pursuit is broken and the breach becomes a true escape path."
            ]
        },
        {
            "id": "safehouse_lantern",
            "speaker": "Safehouse Lantern",
            "prompt": "take shelter",
            "radius": 18.0,
            "position": Vector2(176, 252),
            "color": Color(0.933333, 0.862745, 0.556863, 0.95),
            "lines": PackedStringArray([
                "The quiet shelter compresses the city noise into one smaller decision: travel together or split.",
                "Even the safehouse feels temporary, borrowed, and politically loaded."
            ]),
            "completes_scene": scene_id == "ch02_sc04_terms_of_alliance",
            "completion_status": "The alliance is set and Primm is now committed to the party.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The chapter shifts from pursuit to political consequence."
            ]
        },
        {
            "id": "court_window",
            "speaker": "Court Window",
            "prompt": "listen through the court screen",
            "radius": 18.0,
            "position": Vector2(434, 122),
            "color": Color(0.890196, 0.827451, 0.611765, 0.95),
            "lines": PackedStringArray([
                "Court voices arrive as fragments, but the split is already legible: survival, pride, and fear are no longer aligned.",
                "Documents and messenger routes matter as much as the actual speech."
            ]),
            "completes_scene": scene_id == "ch02_sc05_pandora_court_divides",
            "completion_status": "The court split is now visible enough to change the stakes of the city.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "What Primm fled now has institutional shape instead of rumor."
            ]
        },
        {
            "id": "court_echo",
            "speaker": "Court Route Echo",
            "prompt": "read the route pressure",
            "radius": 18.0,
            "position": Vector2(468, 278),
            "color": Color(0.611765, 0.717647, 0.85098, 0.95),
            "lines": PackedStringArray(scene_info_lines)
        }
    ]


func get_enemy_specs() -> Array:
    if get_primary_scene_id() != "ch02_sc03_court_wall_garden_breach":
        return []

    return [
        {
            "position": Vector2(494, 214),
            "color": Color(0.847059, 0.529412, 0.360784, 1),
            "move_speed": 34.0,
            "idle_radius": 14.0,
            "aggro_radius": 118.0,
            "hit_points": 2
        },
        {
            "position": Vector2(590, 248),
            "color": Color(0.913725, 0.611765, 0.403922, 1),
            "move_speed": 36.0,
            "idle_radius": 12.0,
            "aggro_radius": 118.0,
            "hit_points": 2
        }
    ]
