extends "res://scripts/prototype/prototype_map.gd"


func get_map_id() -> String:
    return "test_room"


func get_map_title() -> String:
    return "Prototype Test Hall"


func get_map_subtitle() -> String:
    if get_active_enemy_count() > 0:
        return "One practice echo is active. Confirm movement, interaction, and first-hit readability here."
    return "Prototype hall clear. Dialogue, switching, and baseline combat input are all live."


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
                "Use WASD or the arrow keys to cross the hall. The center lane is intentionally narrow enough to show whether collisions feel sticky or readable."
            ]
        },
        {
            "id": "dialogue_echo",
            "speaker": "Archive Echo",
            "prompt": "speak to the archive echo",
            "radius": 22.0,
            "position": Vector2(324, 140),
            "color": Color(0.870588, 0.756863, 0.47451, 0.95),
            "lines": [
                "Dialogue is now live as a runtime element rather than a document promise.",
                "This should stay simple: one speaker, readable pacing, and no dependence on final portraits yet."
            ]
        },
        {
            "id": "switch_console",
            "speaker": "Route Console",
            "prompt": "read map switch notes",
            "radius": 20.0,
            "position": Vector2(482, 120),
            "color": Color(0.556863, 0.74902, 0.85098, 0.95),
            "lines": [
                "Press 1, 2, or 3 to jump between the test hall, the Water Palace benchmark, and the Forbidden Falls benchmark.",
                "Tab also cycles forward if you want to walk the prototype slice in sequence."
            ]
        }
    ]


func get_enemy_specs() -> Array:
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
