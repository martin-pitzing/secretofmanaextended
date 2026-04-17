extends "res://scripts/prototype/prototype_map.gd"


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
    return Color(0.0745098, 0.0823529, 0.101961, 1)


func get_wall_color() -> Color:
    return Color(0.196078, 0.2, 0.223529, 1)


func get_wall_outline_color() -> Color:
    return Color(0.337255, 0.360784, 0.392157, 1)


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(44, 44, 616, 328), "color": Color(0.537255, 0.52549, 0.490196, 1)},
        {"rect": Rect2(70, 72, 250, 126), "color": Color(0.647059, 0.607843, 0.482353, 1)},
        {"rect": Rect2(344, 72, 244, 116), "color": Color(0.584314, 0.568627, 0.513725, 1)},
        {"rect": Rect2(92, 220, 270, 104), "color": Color(0.564706, 0.541176, 0.482353, 1)},
        {"rect": Rect2(398, 220, 208, 112), "color": Color(0.490196, 0.462745, 0.419608, 1)},
        {"rect": Rect2(88, 346, 190, 16), "color": Color(0.384314, 0.317647, 0.203922, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(96, 96, 150, 18), "color": Color(0.772549, 0.627451, 0.388235, 1)},
        {"rect": Rect2(140, 244, 120, 38), "color": Color(0.796078, 0.741176, 0.552941, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(412, 250, 64, 54), "color": Color(0.686275, 0.654902, 0.552941, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(482, 98, 38, 82), "color": Color(0.392157, 0.466667, 0.54902, 1)},
        {"rect": Rect2(538, 98, 28, 82), "color": Color(0.392157, 0.466667, 0.54902, 1)}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(170, 124), "radius": 18.0, "color": Color(0.972549, 0.839216, 0.568627, 0.16)},
        {"position": Vector2(214, 262), "radius": 18.0, "color": Color(0.796078, 0.74902, 0.560784, 0.14)},
        {"position": Vector2(524, 136), "radius": 18.0, "color": Color(0.611765, 0.745098, 0.878431, 0.18)},
        {"position": Vector2(500, 284), "radius": 16.0, "color": Color(0.639216, 0.72549, 0.866667, 0.18)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(332, 80), "to": Vector2(332, 352), "color": Color(0.301961, 0.317647, 0.360784, 1), "width": 2.0},
        {"from": Vector2(86, 208), "to": Vector2(618, 208), "color": Color(0.301961, 0.317647, 0.360784, 1), "width": 2.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(44, 44, 616, 18),
        Rect2(44, 354, 616, 18),
        Rect2(44, 62, 18, 292),
        Rect2(642, 62, 18, 292),
        Rect2(320, 72, 18, 264),
        Rect2(62, 198, 258, 18),
        Rect2(338, 198, 304, 18),
        Rect2(278, 336, 60, 18)
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
            "color": Color(0.882353, 0.74902, 0.454902, 0.95),
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
            "color": Color(0.952941, 0.772549, 0.423529, 0.95),
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
            "color": Color(0.713725, 0.788235, 0.92549, 0.95),
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
            "color": Color(0.611765, 0.717647, 0.85098, 0.95),
            "lines": PackedStringArray(scene_info_lines)
        }
    ]
