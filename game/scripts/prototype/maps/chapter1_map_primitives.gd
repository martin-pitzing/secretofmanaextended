extends RefCounted

class_name Chapter1MapPrimitives


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


static func circle_draw(position: Vector2, radius: float, color: Color) -> Dictionary:
    return {
        "position": position,
        "radius": radius,
        "color": color
    }


static func line_draw(start: Vector2, end: Vector2, color: Color, width: float = 2.0) -> Dictionary:
    return {
        "from": start,
        "to": end,
        "color": color,
        "width": width
    }


static func cloth_strip(rect: Rect2, cloth_color: Color, trim_color: Color, trim_height: float = 3.0) -> Array:
    var entries := [
        rect_fill(rect, cloth_color)
    ]
    if trim_height > 0.0:
        entries.append(rect_fill(Rect2(rect.position.x, rect.end.y - trim_height, rect.size.x, trim_height), trim_color))
    return entries


static func crate_cluster(rects: Array, light_color: Color, dark_color: Color) -> Array:
    var entries := []
    for index in range(rects.size()):
        var rect: Rect2 = rects[index]
        entries.append(rect_fill(rect, light_color if index % 2 == 0 else dark_color))
    return entries
