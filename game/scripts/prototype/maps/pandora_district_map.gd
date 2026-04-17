extends "res://scripts/prototype/prototype_map.gd"

const PandoraMapPrimitives = preload("res://scripts/prototype/maps/pandora_map_primitives.gd")

var _palette := PandoraMapPrimitives.civic_palette()


func get_map_id() -> String:
    return "pandora_gate_district"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Pandora Gate District"
    return "%s Benchmark" % scene.get("title", "Pandora Gate District")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "Pandora gate district"))
    return "%s | %s." % [quest_title, location]


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 704, 416)


func get_spawn_position() -> Vector2:
    match get_primary_scene_id():
        "ch01_sc08_pandora_gate_district":
            return Vector2(126, 326)
        "ch02_sc01_gate_district_morning_after":
            return Vector2(214, 294)
        "ch02_sc02_rumors_of_dyluck":
            return Vector2(238, 248)
        _:
            return Vector2(214, 294)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        PandoraMapPrimitives.rect_fill(Rect2(44, 44, 616, 328), _palette["plaza_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(70, 78, 166, 104), _palette["inn_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(252, 78, 236, 88), _palette["ration_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(502, 78, 122, 104), _palette["checkpoint_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(86, 216, 222, 96), _palette["relief_yard"]),
        PandoraMapPrimitives.rect_fill(Rect2(330, 188, 128, 148), _palette["storehouse_stone"]),
        PandoraMapPrimitives.rect_fill(Rect2(390, 226, 214, 98), _palette["sealed_store"]),
        PandoraMapPrimitives.rect_fill(Rect2(88, 336, 238, 18), _palette["timber_main"]),
        PandoraMapPrimitives.rect_fill(Rect2(332, 336, 168, 18), _palette["timber_mid"]),
        PandoraMapPrimitives.rect_fill(Rect2(518, 336, 98, 18), _palette["timber_dark"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append_array(PandoraMapPrimitives.hanging_banner(Rect2(86, 92, 134, 14), _palette["banner_cloth"], _palette["banner_trim"], 3.0))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(146, 86, 34, 52), _palette["inn_sign"]))
    overlays.append_array(PandoraMapPrimitives.notice_grid(Vector2(270, 94), 2, 2, Vector2(84, 24), Vector2(10, 8), _palette["notice_paper"]))
    overlays.append_array(PandoraMapPrimitives.hanging_banner(Rect2(516, 96, 26, 72), _palette["banner_cloth"], _palette["banner_trim"], 5.0))
    overlays.append_array(PandoraMapPrimitives.hanging_banner(Rect2(584, 96, 26, 72), _palette["banner_cloth"], _palette["banner_trim"], 5.0))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(138, 236, 96, 32), _palette["notice_paper"], 2.0))
    overlays.append_array(PandoraMapPrimitives.crate_cluster([
        Rect2(176, 228, 48, 16),
        Rect2(244, 238, 22, 18),
        Rect2(244, 260, 30, 22)
    ], _palette["crate_light"], _palette["crate_dark"]))
    overlays.append(PandoraMapPrimitives.rect_outline(Rect2(462, 244, 60, 66), _palette["banner_trim"], 2.0))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(540, 246, 34, 58), _palette["corruption_patch"]))
    overlays.append(PandoraMapPrimitives.rect_fill(Rect2(408, 246, 32, 50), _palette["checkpoint_booth"]))
    return overlays


func get_circle_draws() -> Array:
    var circles := []
    circles.append_array(PandoraMapPrimitives.glow_pair(Vector2(108, 116), 18.0, _palette["lantern_outer"], 12.0, _palette["lantern_inner"]))
    circles.append({
        "position": Vector2(212, 248),
        "radius": 18.0,
        "color": _palette["relief_glow"]
    })
    circles.append({
        "position": Vector2(522, 126),
        "radius": 16.0,
        "color": _palette["gate_lantern"]
    })
    circles.append({
        "position": Vector2(592, 126),
        "radius": 16.0,
        "color": _palette["gate_lantern"]
    })
    circles.append_array(PandoraMapPrimitives.glow_pair(Vector2(486, 278), 16.0, _palette["corruption_outer"], 14.0, _palette["corruption_inner"]))
    return circles


func get_line_draws() -> Array:
    return [
        {"from": Vector2(252, 88), "to": Vector2(252, 346), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(490, 88), "to": Vector2(490, 346), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(86, 208), "to": Vector2(618, 208), "color": _palette["route_divider"], "width": 2.0},
        {"from": Vector2(284, 106), "to": Vector2(438, 106), "color": _palette["queue_guide"], "width": 2.0},
        {"from": Vector2(284, 138), "to": Vector2(438, 138), "color": _palette["queue_guide"], "width": 2.0},
        {"from": Vector2(110, 344), "to": Vector2(596, 344), "color": _palette["wood_lane"], "width": 3.0},
        {"from": Vector2(430, 240), "to": Vector2(430, 304), "color": _palette["checkpoint_mark"], "width": 2.0},
        {"from": Vector2(552, 240), "to": Vector2(552, 304), "color": _palette["corruption_mark"], "width": 2.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(44, 44, 616, 18),
        Rect2(44, 354, 616, 18),
        Rect2(44, 62, 18, 292),
        Rect2(642, 62, 18, 292),
        Rect2(62, 70, 184, 18),
        Rect2(62, 88, 18, 120),
        Rect2(228, 88, 18, 120),
        Rect2(62, 190, 48, 18),
        Rect2(144, 190, 102, 18),
        Rect2(270, 176, 74, 14),
        Rect2(376, 176, 96, 14),
        Rect2(500, 78, 124, 18),
        Rect2(500, 96, 18, 92),
        Rect2(606, 96, 18, 92),
        Rect2(500, 170, 36, 18),
        Rect2(558, 170, 66, 18),
        Rect2(390, 222, 214, 18),
        Rect2(390, 240, 18, 94),
        Rect2(586, 240, 18, 94),
        Rect2(390, 316, 72, 18),
        Rect2(496, 316, 108, 18)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var quest_id := get_primary_quest_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var quest_info_lines := quest_lines(quest_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Advance deeper into Pandora's civic pressure route."))
    var scene_location := str(scene.get("location", "Pandora gate district"))

    return [
        {
            "id": "inn_shelter",
            "speaker": "Inn Lantern",
            "prompt": "take shelter",
            "radius": 18.0,
            "position": Vector2(108, 170),
            "color": _palette["trigger_safe"],
            "lines": PackedStringArray([
                "Pandora's crisis is visible before the court ever speaks.",
                "The inn serves as the first stable node inside a kingdom already forcing its crisis inward."
            ]),
            "completes_scene": scene_id == "ch01_sc08_pandora_gate_district",
            "completion_status": "Pandora's first safe node is reached.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The city is entered, the strain is visible, and Chapter 1 can close."
            ]
        },
        {
            "id": "relief_board",
            "speaker": "Relief Notice Board",
            "prompt": "inspect the relief decrees",
            "radius": 18.0,
            "position": Vector2(170, 106),
            "color": _palette["trigger_notice"],
            "lines": PackedStringArray([
                "Location: %s" % scene_location,
                "Beat: %s" % str(scene.get("narrative_beat", "Pandora is controlling the visible surface of its crisis.")),
                "Props: ration lines, decrees, and checkpoint language tell the story before the court does."
            ]),
            "completes_scene": scene_id == "ch02_sc01_gate_district_morning_after",
            "completion_status": "You have read enough of the city's surface pressure to move deeper.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The relief board turns the city's public face into evidence instead of decoration."
            ]
        },
        {
            "id": "wounded_courier",
            "speaker": "Wounded Courier",
            "prompt": "hear the courier's account",
            "radius": 18.0,
            "position": Vector2(208, 264),
            "color": _palette["trigger_courier"],
            "lines": PackedStringArray([
                "Quest pressure: %s" % str(quest_info_lines[0]) if not quest_info_lines.is_empty() else "Quest pressure: rumors are politically fragmented.",
                "The stories about Dyluck do not disagree by accident; they disagree because each faction needs a different version.",
                "A city in crisis turns rumor into governance."
            ]),
            "completes_scene": scene_id == "ch02_sc02_rumors_of_dyluck",
            "completion_status": "You have enough conflicting testimony to move toward Primm's route.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The rumor trail stops sounding random and starts sounding curated."
            ]
        },
        {
            "id": "chapter_echo",
            "speaker": "Gate District Echo",
            "prompt": "read the district pressure",
            "radius": 18.0,
            "position": Vector2(474, 272),
            "color": _palette["trigger_echo"],
            "lines": PackedStringArray(scene_info_lines)
        }
    ]
