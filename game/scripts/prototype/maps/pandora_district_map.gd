extends "res://scripts/prototype/prototype_map.gd"


func get_map_id() -> String:
    return "pandora_district_civic_knot"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Pandora District Civic Knot"
    return "%s Benchmark" % scene.get("title", "Pandora District Civic Knot")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "Pandora civic district"))
    if get_active_enemy_count() > 0:
        return "%s | Pressure active in %s." % [quest_title, location]
    return "%s | %s." % [quest_title, location]


func get_status_text() -> String:
    if get_active_enemy_count() > 0:
        return "Active threat count: %d" % get_active_enemy_count()
    return get_map_subtitle()


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 736, 448)


func get_spawn_position() -> Vector2:
    match get_primary_scene_id():
        "ch01_sc08_pandora_gate_district":
            return Vector2(120, 350)
        "ch02_sc01_gate_district_morning_after":
            return Vector2(188, 334)
        "ch02_sc02_rumors_of_dyluck":
            return Vector2(216, 276)
        "ch02_sc03_court_wall_garden_breach":
            return Vector2(558, 248)
        "ch02_sc04_terms_of_alliance":
            return Vector2(190, 142)
        "ch02_sc05_pandora_court_divides":
            return Vector2(470, 108)
        "ch02_sc06_kroll_offer":
            return Vector2(364, 228)
        "ch02_sc07_mission_ledger":
            return Vector2(594, 336)
        "ch02_sc08_departure_lower_gate":
            return Vector2(138, 340)
        _:
            return Vector2(188, 334)


func get_background_color() -> Color:
    return Color(0.0705882, 0.0784314, 0.0980392, 1)


func get_wall_color() -> Color:
    return Color(0.184314, 0.203922, 0.223529, 1)


func get_wall_outline_color() -> Color:
    return Color(0.317647, 0.356863, 0.392157, 1)


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(42, 42, 652, 364), "color": Color(0.482353, 0.482353, 0.447059, 1)},
        {"rect": Rect2(70, 76, 236, 132), "color": Color(0.619608, 0.588235, 0.470588, 1)},
        {"rect": Rect2(330, 78, 292, 154), "color": Color(0.537255, 0.537255, 0.490196, 1)},
        {"rect": Rect2(80, 234, 332, 128), "color": Color(0.556863, 0.533333, 0.47451, 1)},
        {"rect": Rect2(438, 254, 210, 116), "color": Color(0.454902, 0.431373, 0.392157, 1)},
        {"rect": Rect2(98, 374, 226, 18), "color": Color(0.368627, 0.305882, 0.196078, 1)},
        {"rect": Rect2(350, 112, 250, 14), "color": Color(0.678431, 0.666667, 0.607843, 1)},
        {"rect": Rect2(520, 96, 66, 112), "color": Color(0.439216, 0.537255, 0.403922, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(92, 98, 192, 18), "color": Color(0.756863, 0.619608, 0.372549, 1)},
        {"rect": Rect2(356, 96, 88, 56), "color": Color(0.717647, 0.592157, 0.32549, 1)},
        {"rect": Rect2(470, 98, 34, 92), "color": Color(0.717647, 0.709804, 0.658824, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(548, 278, 68, 60), "color": Color(0.654902, 0.627451, 0.52549, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(146, 268, 118, 40), "color": Color(0.772549, 0.721569, 0.541176, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(118, 150, 92, 36), "color": Color(0.329412, 0.372549, 0.470588, 1)}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(396, 168), "radius": 22.0, "color": Color(0.960784, 0.831373, 0.588235, 0.18)},
        {"position": Vector2(556, 150), "radius": 18.0, "color": Color(0.658824, 0.827451, 0.607843, 0.2)},
        {"position": Vector2(176, 284), "radius": 20.0, "color": Color(0.819608, 0.756863, 0.513725, 0.14)},
        {"position": Vector2(578, 320), "radius": 16.0, "color": Color(0.607843, 0.721569, 0.866667, 0.18)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(316, 104), "to": Vector2(316, 388), "color": Color(0.278431, 0.305882, 0.345098, 1), "width": 2.0},
        {"from": Vector2(84, 222), "to": Vector2(648, 222), "color": Color(0.278431, 0.305882, 0.345098, 1), "width": 2.0},
        {"from": Vector2(508, 92), "to": Vector2(612, 194), "color": Color(0.482353, 0.658824, 0.470588, 0.65), "width": 3.0},
        {"from": Vector2(522, 242), "to": Vector2(620, 242), "color": Color(0.345098, 0.372549, 0.415686, 1), "width": 2.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(42, 42, 652, 18),
        Rect2(42, 388, 652, 18),
        Rect2(42, 60, 18, 328),
        Rect2(676, 60, 18, 328),
        Rect2(306, 76, 20, 296),
        Rect2(60, 208, 246, 18),
        Rect2(326, 232, 350, 18),
        Rect2(504, 76, 18, 96),
        Rect2(622, 250, 18, 120),
        Rect2(118, 326, 208, 18)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var quest_id := get_primary_quest_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var quest_info_lines := quest_lines(quest_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Advance through Pandora's civic pressure route."))
    var scene_location := str(scene.get("location", "Pandora district"))

    return [
        {
            "id": "relief_board",
            "speaker": "Relief Notice Board",
            "prompt": "inspect the relief decrees",
            "radius": 18.0,
            "position": Vector2(156, 106),
            "color": Color(0.956863, 0.776471, 0.423529, 0.95),
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
            "position": Vector2(196, 286),
            "color": Color(0.717647, 0.788235, 0.92549, 0.95),
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
            "id": "garden_gap",
            "speaker": "Service Gate Breach",
            "prompt": "slip through the garden breach",
            "radius": 20.0,
            "position": Vector2(556, 146),
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
            "position": Vector2(158, 158),
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
            "id": "inn_shelter",
            "speaker": "Inn Lantern",
            "prompt": "take shelter at the inn",
            "radius": 18.0,
            "position": Vector2(110, 180),
            "color": Color(0.878431, 0.741176, 0.45098, 0.95),
            "lines": PackedStringArray([
                "Pandora's crisis is visible before the court ever speaks.",
                "The inn serves as the first safe civic node inside a kingdom already splitting under pressure."
            ]),
            "completes_scene": scene_id == "ch01_sc08_pandora_gate_district",
            "completion_status": "Pandora's first safe node is reached.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The city is entered, the strain is visible, and Chapter 1 can close."
            ]
        },
        {
            "id": "court_window",
            "speaker": "Court Window",
            "prompt": "listen through the court screen",
            "radius": 18.0,
            "position": Vector2(396, 112),
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
            "id": "kroll_dais",
            "speaker": "Imperial Receiving Dais",
            "prompt": "watch Kroll's address",
            "radius": 22.0,
            "position": Vector2(392, 168),
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
            "position": Vector2(584, 316),
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
            "position": Vector2(214, 382),
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
            "id": "chapter_echo",
            "speaker": "City Echo",
            "prompt": "read the district pressure",
            "radius": 18.0,
            "position": Vector2(470, 292),
            "color": Color(0.607843, 0.717647, 0.85098, 0.95),
            "lines": PackedStringArray(scene_info_lines)
        }
    ]


func get_enemy_specs() -> Array:
    match get_primary_scene_id():
        "ch02_sc03_court_wall_garden_breach":
            return [
                {
                    "position": Vector2(520, 198),
                    "color": Color(0.847059, 0.529412, 0.360784, 1),
                    "move_speed": 34.0,
                    "idle_radius": 14.0,
                    "aggro_radius": 118.0,
                    "hit_points": 2
                },
                {
                    "position": Vector2(612, 230),
                    "color": Color(0.913725, 0.611765, 0.403922, 1),
                    "move_speed": 36.0,
                    "idle_radius": 12.0,
                    "aggro_radius": 118.0,
                    "hit_points": 2
                }
            ]
        "ch02_sc07_mission_ledger":
            return [
                {
                    "position": Vector2(552, 278),
                    "color": Color(0.831373, 0.505882, 0.337255, 1),
                    "move_speed": 33.0,
                    "idle_radius": 14.0,
                    "aggro_radius": 112.0,
                    "hit_points": 2
                },
                {
                    "position": Vector2(624, 336),
                    "color": Color(0.905882, 0.580392, 0.372549, 1),
                    "move_speed": 35.0,
                    "idle_radius": 12.0,
                    "aggro_radius": 112.0,
                    "hit_points": 2
                }
            ]
        _:
            return []
