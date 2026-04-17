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
        PandoraMapPrimitives.rect_fill(Rect2(42, 44, 652, 344), _palette["gate_yard"]),
        PandoraMapPrimitives.rect_fill(Rect2(78, 76, 222, 114), _palette["gate_yard"]),
        PandoraMapPrimitives.rect_fill(Rect2(320, 72, 176, 108), _palette["receiving_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(510, 72, 118, 130), _palette["archive_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(88, 224, 228, 118), _palette["relief_floor"]),
        PandoraMapPrimitives.rect_fill(Rect2(334, 212, 110, 128), _palette["ledger_hall"]),
        PandoraMapPrimitives.rect_fill(Rect2(390, 218, 246, 126), _palette["archive_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(116, 360, 202, 16), _palette["outbound_lane"]),
        PandoraMapPrimitives.rect_fill(Rect2(336, 360, 160, 16), _palette["timber_mid"]),
        PandoraMapPrimitives.rect_fill(Rect2(516, 360, 104, 16), _palette["timber_dark"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append_array(PandoraMapPrimitives.hanging_banner(Rect2(362, 94, 104, 56), _palette["imperial_cloth"], _palette["banner_trim"], 6.0))
    overlays.append_array(PandoraMapPrimitives.notice_grid(Vector2(520, 96), 2, 2, Vector2(34, 22), Vector2(10, 10), _palette["archive_frame"]))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(448, 248, 92, 66), _palette["banner_trim"], 2.0))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(562, 244, 24, 62), _palette["damage_mark"]))
    overlays.append_array(PandoraMapPrimitives.crate_cluster([
        Rect2(156, 248, 42, 20),
        Rect2(204, 248, 34, 26),
        Rect2(242, 258, 28, 20)
    ], _palette["crate_light"], _palette["crate_dark"]))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(138, 240, 138, 40), _palette["notice_paper"], 2.0))
    overlays.append_array(PandoraMapPrimitives.hanging_banner(Rect2(128, 96, 136, 18), _palette["banner_cloth"], _palette["banner_trim"], 4.0))
    return overlays


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(420, 144), "radius": 20.0, "color": _palette["imperial_ember"]},
        {"position": Vector2(516, 278), "radius": 18.0, "color": _palette["ledger_glow"]},
        {"position": Vector2(196, 270), "radius": 18.0, "color": _palette["departure_glow"]}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(318, 78), "to": Vector2(318, 374), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(498, 78), "to": Vector2(498, 374), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(84, 212), "to": Vector2(644, 212), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(112, 352), "to": Vector2(618, 352), "color": _palette["wood_lane"], "width": 3.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(42, 44, 652, 18),
        Rect2(42, 370, 652, 18),
        Rect2(42, 62, 18, 308),
        Rect2(676, 62, 18, 308),
        Rect2(78, 76, 222, 18),
        Rect2(78, 94, 18, 110),
        Rect2(282, 94, 18, 110),
        Rect2(78, 186, 46, 18),
        Rect2(154, 186, 146, 18),
        Rect2(320, 72, 176, 18),
        Rect2(320, 90, 18, 92),
        Rect2(478, 90, 18, 92),
        Rect2(320, 164, 58, 18),
        Rect2(406, 164, 90, 18),
        Rect2(510, 72, 118, 18),
        Rect2(510, 90, 18, 114),
        Rect2(610, 90, 18, 114),
        Rect2(510, 186, 30, 18),
        Rect2(564, 186, 64, 18),
        Rect2(334, 212, 110, 18),
        Rect2(334, 230, 18, 110),
        Rect2(426, 230, 18, 110),
        Rect2(390, 218, 246, 18),
        Rect2(390, 236, 18, 108),
        Rect2(618, 236, 18, 108),
        Rect2(390, 326, 80, 18),
        Rect2(500, 326, 136, 18)
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
            "color": _palette["trigger_dais"],
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
            "color": _palette["trigger_ledger"],
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
            "color": _palette["trigger_departure"],
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
            "color": _palette["trigger_echo"],
            "lines": PackedStringArray(scene_info_lines)
        }
    ]


func get_enemy_specs() -> Array:
    if get_primary_scene_id() != "ch02_sc07_mission_ledger":
        return []

    return [
        {
            "position": Vector2(468, 266),
            "color": _palette["enemy_guard_1"],
            "move_speed": 33.0,
            "idle_radius": 14.0,
            "aggro_radius": 112.0,
            "hit_points": 2
        },
        {
            "position": Vector2(584, 318),
            "color": _palette["enemy_guard_2"],
            "move_speed": 35.0,
            "idle_radius": 12.0,
            "aggro_radius": 112.0,
            "hit_points": 2
        }
    ]
