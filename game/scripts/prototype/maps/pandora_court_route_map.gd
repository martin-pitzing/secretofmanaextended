extends "res://scripts/prototype/prototype_map.gd"

const PandoraMapPrimitives = preload("res://scripts/prototype/maps/pandora_map_primitives.gd")

var _palette := PandoraMapPrimitives.court_palette()


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
            return Vector2(166, 270)
        "ch02_sc05_pandora_court_divides":
            return Vector2(398, 110)
        _:
            return Vector2(166, 270)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        PandoraMapPrimitives.rect_fill(Rect2(42, 42, 620, 330), _palette["service_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(78, 78, 206, 102), _palette["service_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(306, 74, 214, 108), _palette["court_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(520, 74, 104, 110), _palette["garden_patch"]),
        PandoraMapPrimitives.rect_fill(Rect2(102, 218, 182, 112), _palette["safehouse_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(344, 214, 264, 118), _palette["archive_floor"]),
        PandoraMapPrimitives.rect_fill(Rect2(108, 338, 488, 14), _palette["wood_lane"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append_array(PandoraMapPrimitives.hanging_banner(Rect2(118, 92, 126, 14), _palette["banner_cloth"], _palette["banner_trim"], 3.0))
    overlays.append_array(PandoraMapPrimitives.notice_grid(Vector2(362, 96), 2, 2, Vector2(52, 22), Vector2(12, 10), _palette["screen_frame"]))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(392, 94, 42, 54), _palette["screen_gold"]))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(444, 94, 26, 54), _palette["damage_mark"]))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(536, 98, 34, 70), _palette["banner_trim"], 2.0))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(562, 100, 30, 58), _palette["garden_patch"]))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(144, 234, 96, 32), _palette["crate_dark"]))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(136, 228, 112, 44), _palette["notice_paper"], 2.0))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(430, 246, 92, 58), _palette["checkpoint_booth"]))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(526, 246, 44, 60), _palette["screen_frame"], 2.0))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(576, 246, 20, 52), _palette["damage_mark"]))
    return overlays


func get_circle_draws() -> Array:
    var circles := []
    circles.append({
        "position": Vector2(552, 138),
        "radius": 18.0,
        "color": _palette["garden_glow"]
    })
    circles.append({
        "position": Vector2(176, 258),
        "radius": 18.0,
        "color": _palette["safehouse_glow"]
    })
    circles.append({
        "position": Vector2(462, 282),
        "radius": 16.0,
        "color": _palette["court_glow"]
    })
    return circles


func get_line_draws() -> Array:
    return [
        {"from": Vector2(294, 78), "to": Vector2(294, 352), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(94, 204), "to": Vector2(610, 204), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(510, 94), "to": Vector2(604, 176), "color": _palette["garden_guide"], "width": 3.0},
        {"from": Vector2(120, 340), "to": Vector2(594, 340), "color": _palette["wood_lane"], "width": 3.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(42, 42, 620, 18),
        Rect2(42, 354, 620, 18),
        Rect2(42, 60, 18, 294),
        Rect2(644, 60, 18, 294),
        Rect2(60, 74, 228, 18),
        Rect2(60, 92, 18, 112),
        Rect2(270, 92, 18, 94),
        Rect2(60, 186, 56, 18),
        Rect2(146, 186, 142, 18),
        Rect2(306, 74, 214, 18),
        Rect2(306, 92, 18, 90),
        Rect2(502, 92, 18, 90),
        Rect2(306, 182, 64, 14),
        Rect2(396, 182, 124, 14),
        Rect2(520, 74, 104, 18),
        Rect2(520, 92, 18, 88),
        Rect2(606, 92, 18, 88),
        Rect2(520, 162, 28, 18),
        Rect2(570, 162, 54, 18),
        Rect2(102, 218, 182, 18),
        Rect2(102, 236, 18, 94),
        Rect2(266, 236, 18, 94),
        Rect2(102, 312, 52, 18),
        Rect2(178, 312, 106, 18),
        Rect2(344, 214, 264, 18),
        Rect2(344, 232, 18, 100),
        Rect2(590, 232, 18, 100),
        Rect2(344, 314, 78, 18),
        Rect2(454, 314, 154, 18)
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
            "position": Vector2(552, 138),
            "color": _palette["trigger_breach"],
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
            "position": Vector2(176, 258),
            "color": _palette["trigger_safehouse"],
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
            "color": _palette["trigger_court"],
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
            "color": _palette["trigger_echo"],
            "lines": PackedStringArray(scene_info_lines)
        }
    ]


func get_enemy_specs() -> Array:
    if get_primary_scene_id() != "ch02_sc03_court_wall_garden_breach":
        return []

    return [
        {
            "position": Vector2(478, 248),
            "color": _palette["enemy_guard_1"],
            "move_speed": 34.0,
            "idle_radius": 14.0,
            "aggro_radius": 118.0,
            "hit_points": 2
        },
        {
            "position": Vector2(552, 276),
            "color": _palette["enemy_guard_2"],
            "move_speed": 36.0,
            "idle_radius": 12.0,
            "aggro_radius": 118.0,
            "hit_points": 2
        }
    ]
