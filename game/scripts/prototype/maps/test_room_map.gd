extends "res://scripts/prototype/prototype_map.gd"


func get_map_id() -> String:
    return "test_room"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Prototype Test Hall"
    return "%s Staging Room" % scene.get("title", "Prototype Test Hall")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var scene_title := str(scene.get("title", "No scene data"))
    var quest_title := str(quest.get("title", "No quest data"))
    if get_active_enemy_count() > 0:
        return "%s / %s. One practice echo is active for baseline combat checks." % [scene_title, quest_title]
    return "%s / %s. Staging map is carrying the current story scene until a dedicated graybox space exists." % [scene_title, quest_title]


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 640, 360)


func get_spawn_position() -> Vector2:
    return Vector2(120, 188)


func get_background_color() -> Color:
    return Color(0.054902, 0.0745098, 0.105882, 1)


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(32, 32, 576, 296), "color": Color(0.109804, 0.14902, 0.180392, 1)},
        {"rect": Rect2(72, 72, 180, 96), "color": Color(0.180392, 0.239216, 0.27451, 1)},
        {"rect": Rect2(266, 72, 116, 200), "color": Color(0.14902, 0.203922, 0.227451, 1)},
        {"rect": Rect2(396, 72, 172, 96), "color": Color(0.180392, 0.239216, 0.27451, 1)},
        {"rect": Rect2(72, 216, 496, 72), "color": Color(0.121569, 0.164706, 0.196078, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(94, 94, 136, 52), "color": Color(0.278431, 0.372549, 0.423529, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(290, 94, 68, 156), "color": Color(0.309804, 0.419608, 0.47451, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(418, 94, 128, 52), "color": Color(0.278431, 0.372549, 0.423529, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(276, 226, 96, 36), "color": Color(0.517647, 0.419608, 0.235294, 1)}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(162, 120), "radius": 14.0, "color": Color(0.537255, 0.682353, 0.780392, 0.22)},
        {"position": Vector2(324, 140), "radius": 18.0, "color": Color(0.756863, 0.654902, 0.454902, 0.18)},
        {"position": Vector2(482, 120), "radius": 14.0, "color": Color(0.537255, 0.682353, 0.780392, 0.22)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(104, 180), "to": Vector2(536, 180), "color": Color(0.219608, 0.290196, 0.333333, 1), "width": 2.0},
        {"from": Vector2(320, 216), "to": Vector2(320, 286), "color": Color(0.447059, 0.376471, 0.223529, 1), "width": 2.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(32, 32, 576, 16),
        Rect2(32, 312, 576, 16),
        Rect2(32, 48, 16, 264),
        Rect2(592, 48, 16, 264),
        Rect2(252, 72, 14, 96),
        Rect2(382, 72, 14, 96),
        Rect2(252, 182, 14, 90),
        Rect2(382, 182, 14, 90)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var primary_scene_id := get_primary_scene_id()
    var primary_quest_id := get_primary_quest_id()
    var scene_info_lines := scene_lines(primary_scene_id, 3)
    var quest_info_lines := quest_lines(primary_quest_id, 3)
    var archive_lines := PackedStringArray()
    archive_lines.append_array(scene_info_lines)
    archive_lines.append_array(quest_info_lines)
    var counts := get_loaded_content_counts()
    var requires_enemy_clear := _scene_needs_combat_clear(scene)
    var exit_condition := str(scene.get("exit_condition", "Move onward through the current story route."))

    return [
        {
            "id": "movement_sign",
            "speaker": "Caretaker Board",
            "prompt": "read movement notes",
            "radius": 20.0,
            "position": Vector2(162, 120),
            "color": Color(0.556863, 0.74902, 0.85098, 0.95),
            "lines": [
                "This hall is the first runtime check: movement, collision, prompt range, and camera follow all have to feel stable before art arrives.",
                "The loader currently has %d scene mirrors and %d quest mirrors from Chapters 1 and 2 available to the prototype." % [counts.get("scene_count", 0), counts.get("quest_count", 0)],
                "When a current story scene does not have a dedicated benchmark map yet, it lands here instead of falling back to placeholder-only UI."
            ]
        },
        {
            "id": "dialogue_echo",
            "speaker": "Archive Echo",
            "prompt": "speak to the archive echo",
            "radius": 22.0,
            "position": Vector2(324, 140),
            "color": Color(0.870588, 0.756863, 0.47451, 0.95),
            "lines": archive_lines
        },
        {
            "id": "switch_console",
            "speaker": "Route Console",
            "prompt": "read map switch notes",
            "radius": 20.0,
            "position": Vector2(482, 120),
            "color": Color(0.556863, 0.74902, 0.85098, 0.95),
            "lines": [
                "Story scenes now advance through in-world gates instead of the old N-key debug skip.",
                "Press R to restart the active chapter, C to return to story-driven map routing, or 1, 2, 3, 4 and Tab for manual benchmark inspection."
            ]
        },
        {
            "id": "story_gate",
            "speaker": "Route Marker",
            "prompt": "follow the story route",
            "radius": 24.0,
            "position": Vector2(324, 246),
            "color": Color(0.945098, 0.839216, 0.505882, 0.95),
            "completes_scene": true,
            "requires_enemy_clear": requires_enemy_clear,
            "blocked_status": "The staging route stays sealed until the nearby echo is cleared.",
            "blocked_lines": [
                "The route marker is still unstable.",
                "Clear the nearby echo before taking the scene handoff."
            ],
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "This staging marker stands in for the scene-specific exit until a dedicated graybox map exists.",
                "Quest handoff remains tied to the editorial scene and quest mirrors."
            ]
        }
    ]


func get_enemy_specs() -> Array:
    var scene := get_primary_scene_record()
    if not _scene_needs_combat_clear(scene):
        return []

    return [
        {
            "position": Vector2(320, 250),
            "color": Color(0.784314, 0.470588, 0.337255, 1),
            "move_speed": 26.0,
            "idle_radius": 10.0,
            "aggro_radius": 96.0,
            "hit_points": 2
        }
    ]


func _scene_needs_combat_clear(scene: Dictionary) -> bool:
    var scene_title := str(scene.get("title", "")).to_lower()
    var player_goal := str(scene.get("player_goal", "")).to_lower()
    var gameplay_beat := list_to_sentence(scene.get("gameplay_beat", [])).to_lower()
    return (
        scene_title.contains("forbidden") or
        scene_title.contains("road") or
        player_goal.contains("survive") or
        gameplay_beat.contains("combat") or
        gameplay_beat.contains("threat")
    )
