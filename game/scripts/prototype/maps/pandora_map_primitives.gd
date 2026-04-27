extends RefCounted

class_name PandoraMapPrimitives


static func shared_palette() -> Dictionary:
    return {
        "banner_cloth": Color(0.560784, 0.262745, 0.243137, 1),
        "banner_trim": Color(0.737255, 0.678431, 0.501961, 1),
        "notice_paper": Color(0.780392, 0.721569, 0.537255, 1),
        "crate_light": Color(0.494118, 0.337255, 0.219608, 1),
        "crate_dark": Color(0.447059, 0.301961, 0.203922, 1),
        "checkpoint_booth": Color(0.356863, 0.372549, 0.427451, 1),
        "route_divider": Color(0.282353, 0.294118, 0.333333, 0.85),
        "wood_lane": Color(0.447059, 0.352941, 0.227451, 0.9),
        "queue_guide": Color(0.803922, 0.733333, 0.529412, 0.5),
        "lantern_outer": Color(0.972549, 0.839216, 0.568627, 0.18),
        "lantern_inner": Color(0.941176, 0.811765, 0.529412, 0.14),
        "relief_glow": Color(0.839216, 0.752941, 0.552941, 0.14),
        "gate_lantern": Color(0.839216, 0.784314, 0.596078, 0.14),
        "corruption_outer": Color(0.580392, 0.439216, 0.654902, 0.18),
        "corruption_inner": Color(0.486275, 0.341176, 0.580392, 0.16),
        "corruption_patch": Color(0.415686, 0.227451, 0.419608, 0.68),
        "checkpoint_mark": Color(0.435294, 0.45098, 0.501961, 0.7),
        "corruption_mark": Color(0.529412, 0.290196, 0.54902, 0.65),
        "trigger_safe": Color(0.882353, 0.74902, 0.454902, 0.95),
        "trigger_notice": Color(0.952941, 0.772549, 0.423529, 0.95),
        "trigger_courier": Color(0.713725, 0.788235, 0.92549, 0.95),
        "trigger_echo": Color(0.611765, 0.717647, 0.85098, 0.95),
        "enemy_guard_1": Color(0.847059, 0.529412, 0.360784, 1),
        "enemy_guard_2": Color(0.913725, 0.611765, 0.403922, 1)
    }


static func civic_palette() -> Dictionary:
    var palette := shared_palette()
    palette["background"] = Color(0.0705882, 0.0784314, 0.101961, 1)
    palette["wall"] = Color(0.2, 0.203922, 0.227451, 1)
    palette["wall_outline"] = Color(0.352941, 0.360784, 0.396078, 1)
    palette["plaza_stone"] = Color(0.454902, 0.447059, 0.427451, 1)
    palette["inn_stone"] = Color(0.627451, 0.584314, 0.470588, 1)
    palette["ration_stone"] = Color(0.588235, 0.556863, 0.470588, 1)
    palette["checkpoint_stone"] = Color(0.498039, 0.494118, 0.47451, 1)
    palette["relief_yard"] = Color(0.556863, 0.52549, 0.458824, 1)
    palette["storehouse_stone"] = Color(0.521569, 0.498039, 0.439216, 1)
    palette["sealed_store"] = Color(0.447059, 0.415686, 0.392157, 1)
    palette["timber_main"] = Color(0.376471, 0.309804, 0.207843, 1)
    palette["timber_mid"] = Color(0.360784, 0.301961, 0.207843, 1)
    palette["timber_dark"] = Color(0.333333, 0.278431, 0.188235, 1)
    palette["inn_sign"] = Color(0.694118, 0.647059, 0.486275, 1)
    return palette


static func court_palette() -> Dictionary:
    var palette := shared_palette()
    palette["background"] = Color(0.0666667, 0.0745098, 0.0941176, 1)
    palette["wall"] = Color(0.203922, 0.215686, 0.239216, 1)
    palette["wall_outline"] = Color(0.34902, 0.364706, 0.4, 1)
    palette["service_stone"] = Color(0.54902, 0.529412, 0.482353, 1)
    palette["court_stone"] = Color(0.658824, 0.631373, 0.572549, 1)
    palette["safehouse_stone"] = Color(0.494118, 0.458824, 0.411765, 1)
    palette["archive_floor"] = Color(0.564706, 0.541176, 0.490196, 1)
    palette["garden_patch"] = Color(0.431373, 0.541176, 0.419608, 1)
    palette["screen_gold"] = Color(0.792157, 0.705882, 0.470588, 1)
    palette["screen_frame"] = Color(0.713725, 0.654902, 0.513725, 1)
    palette["damage_mark"] = Color(0.470588, 0.239216, 0.262745, 0.72)
    palette["garden_guide"] = Color(0.478431, 0.658824, 0.466667, 0.65)
    palette["safehouse_glow"] = Color(0.858824, 0.784314, 0.552941, 0.16)
    palette["garden_glow"] = Color(0.678431, 0.870588, 0.627451, 0.2)
    palette["court_glow"] = Color(0.917647, 0.815686, 0.588235, 0.16)
    palette["trigger_breach"] = Color(0.65098, 0.878431, 0.611765, 0.95)
    palette["trigger_safehouse"] = Color(0.933333, 0.862745, 0.556863, 0.95)
    palette["trigger_court"] = Color(0.890196, 0.827451, 0.611765, 0.95)
    return palette


static func annex_palette() -> Dictionary:
    var palette := shared_palette()
    palette["background"] = Color(0.0705882, 0.0784314, 0.101961, 1)
    palette["wall"] = Color(0.188235, 0.203922, 0.227451, 1)
    palette["wall_outline"] = Color(0.337255, 0.356863, 0.392157, 1)
    palette["gate_yard"] = Color(0.521569, 0.501961, 0.458824, 1)
    palette["receiving_stone"] = Color(0.615686, 0.580392, 0.486275, 1)
    palette["archive_stone"] = Color(0.54902, 0.529412, 0.478431, 1)
    palette["relief_floor"] = Color(0.556863, 0.529412, 0.470588, 1)
    palette["ledger_hall"] = Color(0.470588, 0.439216, 0.392157, 1)
    palette["outbound_lane"] = Color(0.388235, 0.317647, 0.203922, 1)
    palette["timber_main"] = Color(0.376471, 0.309804, 0.207843, 1)
    palette["timber_mid"] = Color(0.360784, 0.301961, 0.207843, 1)
    palette["timber_dark"] = Color(0.333333, 0.278431, 0.188235, 1)
    palette["imperial_cloth"] = Color(0.576471, 0.270588, 0.231373, 1)
    palette["imperial_ember"] = Color(0.952941, 0.713725, 0.482353, 0.18)
    palette["ledger_glow"] = Color(0.639216, 0.764706, 0.905882, 0.18)
    palette["departure_glow"] = Color(0.921569, 0.823529, 0.584314, 0.14)
    palette["archive_frame"] = Color(0.721569, 0.701961, 0.647059, 1)
    palette["damage_mark"] = Color(0.470588, 0.239216, 0.262745, 0.72)
    palette["trigger_dais"] = Color(0.972549, 0.701961, 0.478431, 0.95)
    palette["trigger_ledger"] = Color(0.654902, 0.780392, 0.92549, 0.95)
    palette["trigger_departure"] = Color(0.952941, 0.843137, 0.545098, 0.95)
    return palette


static func rect_fill(rect: Rect2, color: Color) -> Dictionary:
    return {
        "rect": rect,
        "color": color
    }


static func rect_outline(rect: Rect2, color: Color, width: float = 2.0) -> Dictionary:
    return {
        "rect": rect,
        "color": color,
        "filled": false,
        "width": width
    }


static func hanging_banner(rect: Rect2, cloth_color: Color, trim_color: Color, trim_height: float = 4.0) -> Array:
    var entries := [
        rect_fill(rect, cloth_color)
    ]
    if trim_height > 0.0:
        entries.append(rect_fill(Rect2(rect.position.x, rect.end.y - trim_height, rect.size.x, trim_height), trim_color))
    return entries


static func notice_grid(origin: Vector2, cols: int, rows: int, note_size: Vector2, gap: Vector2, note_color: Color, width: float = 2.0) -> Array:
    var entries := []
    for row in range(rows):
        for col in range(cols):
            var position := origin + Vector2(col * (note_size.x + gap.x), row * (note_size.y + gap.y))
            entries.append(rect_outline(Rect2(position, note_size), note_color, width))
    return entries


static func crate_cluster(rects: Array, light_color: Color, dark_color: Color) -> Array:
    var entries := []
    for index in range(rects.size()):
        var rect: Rect2 = rects[index]
        entries.append(rect_fill(rect, light_color if index % 2 == 0 else dark_color))
    return entries


static func glow_pair(position: Vector2, outer_radius: float, outer_color: Color, inner_radius: float = 0.0, inner_color: Color = Color(0, 0, 0, 0)) -> Array:
    var circles := [
        {
            "position": position,
            "radius": outer_radius,
            "color": outer_color
        }
    ]
    if inner_radius > 0.0:
        circles.append({
            "position": position,
            "radius": inner_radius,
            "color": inner_color
        })
    return circles
