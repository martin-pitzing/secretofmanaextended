extends "res://scripts/prototype/prototype_map.gd"


func get_map_id() -> String:
    return "forbidden_falls_seal_breach"


func get_map_title() -> String:
    return "Forbidden Falls Seal Breach"


func get_map_subtitle() -> String:
    if get_active_enemy_count() > 0:
        return "Seal breach pressure active. Clear the unstable echoes, then inspect the altar and edge reads."
    return "Seal breach pressure stabilised. The altar, approach lane, and hazard edge now read cleanly."


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 672, 416)


func get_spawn_position() -> Vector2:
    return Vector2(132, 318)


func get_background_color() -> Color:
    return Color(0.0313726, 0.0588235, 0.0784314, 1)


func get_wall_color() -> Color:
    return Color(0.121569, 0.164706, 0.156863, 1)


func get_wall_outline_color() -> Color:
    return Color(0.262745, 0.345098, 0.317647, 1)


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(56, 62, 562, 294), "color": Color(0.247059, 0.27451, 0.239216, 1)},
        {"rect": Rect2(86, 90, 496, 238), "color": Color(0.360784, 0.372549, 0.313726, 1)},
        {"rect": Rect2(92, 90, 58, 238), "color": Color(0.176471, 0.388235, 0.509804, 1)},
        {"rect": Rect2(176, 210, 236, 62), "color": Color(0.313726, 0.333333, 0.286275, 1)},
        {"rect": Rect2(418, 168, 126, 82), "color": Color(0.294118, 0.305882, 0.258824, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(250, 156, 86, 86), "color": Color(0.447059, 0.439216, 0.278431, 1)},
        {"rect": Rect2(264, 170, 58, 58), "color": Color(0.729412, 0.694118, 0.396078, 1), "filled": false, "width": 2.0},
        {"rect": Rect2(176, 112, 156, 6), "color": Color(0.623529, 0.686275, 0.701961, 0.55)},
        {"rect": Rect2(476, 112, 36, 24), "color": Color(0.545098, 0.372549, 0.196078, 1)},
        {"rect": Rect2(526, 132, 18, 14), "color": Color(0.545098, 0.372549, 0.196078, 1)}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(120, 132), "radius": 22.0, "color": Color(0.741176, 0.929412, 0.980392, 0.2)},
        {"position": Vector2(298, 198), "radius": 26.0, "color": Color(0.968627, 0.72549, 0.352941, 0.22)},
        {"position": Vector2(298, 198), "radius": 14.0, "color": Color(0.937255, 0.85098, 0.537255, 0.28)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(122, 96), "to": Vector2(122, 322), "color": Color(0.847059, 0.960784, 1, 0.45), "width": 3.0},
        {"from": Vector2(160, 284), "to": Vector2(256, 236), "color": Color(0.529412, 0.572549, 0.486275, 1), "width": 3.0},
        {"from": Vector2(256, 236), "to": Vector2(298, 198), "color": Color(0.529412, 0.572549, 0.486275, 1), "width": 3.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(56, 62, 562, 20),
        Rect2(56, 336, 562, 20),
        Rect2(56, 82, 20, 254),
        Rect2(598, 82, 20, 254),
        Rect2(150, 82, 24, 110),
        Rect2(150, 294, 24, 42),
        Rect2(336, 82, 20, 62),
        Rect2(564, 82, 18, 78),
        Rect2(564, 254, 18, 82)
    ]


func get_trigger_specs() -> Array:
    return [
        {
            "id": "altar_read",
            "speaker": "Broken Seal-Stone",
            "prompt": "inspect the broken seal",
            "radius": 24.0,
            "position": Vector2(298, 198),
            "color": Color(0.956863, 0.776471, 0.423529, 0.95),
            "lines": [
                "This room is the combat benchmark because it has to prove threat, altar readability, and route danger inside one screen read.",
                "The altar stays centered even while enemies move through the approach lane. That is the core layout test."
            ]
        },
        {
            "id": "warning_markers",
            "speaker": "Weathered Warning Ropes",
            "prompt": "inspect the warning markers",
            "radius": 18.0,
            "position": Vector2(494, 124),
            "color": Color(0.694118, 0.815686, 0.901961, 0.95),
            "lines": [
                "These remnants exist to show that the site was never folklore alone.",
                "The graybox already needs to communicate prior containment attempts, not just a dramatic boss arena."
            ]
        }
    ]


func get_enemy_specs() -> Array:
    return [
        {
            "position": Vector2(240, 238),
            "color": Color(0.835294, 0.501961, 0.333333, 1),
            "move_speed": 34.0,
            "idle_radius": 14.0,
            "aggro_radius": 128.0,
            "hit_points": 2
        },
        {
            "position": Vector2(360, 216),
            "color": Color(0.917647, 0.592157, 0.356863, 1),
            "move_speed": 36.0,
            "idle_radius": 12.0,
            "aggro_radius": 128.0,
            "hit_points": 2
        }
    ]
