extends "res://scripts/prototype/prototype_map.gd"


func get_map_id() -> String:
    return "water_palace_inner_chamber"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Water Palace Inner Chamber"
    return "%s Benchmark" % scene.get("title", "Water Palace Inner Chamber")


func get_map_subtitle() -> String:
    var quest := get_primary_quest_record()
    var scene := get_primary_scene_record()
    if quest.is_empty() and scene.is_empty():
        return "Audience path, archive pocket, and ritual basin blocking benchmark."

    var quest_title := str(quest.get("title", "Quest"))
    var player_goal := str(scene.get("player_goal", ""))
    return "%s | %s" % [quest_title, player_goal]


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 576, 384)


func get_spawn_position() -> Vector2:
    return Vector2(288, 314)


func get_background_color() -> Color:
    return Color(0.0431373, 0.0823529, 0.117647, 1)


func get_wall_color() -> Color:
    return Color(0.109804, 0.172549, 0.203922, 1)


func get_wall_outline_color() -> Color:
    return Color(0.247059, 0.368627, 0.415686, 1)


func get_floor_rects() -> Array:
    return [
        {"rect": Rect2(48, 44, 480, 296), "color": Color(0.682353, 0.756863, 0.772549, 1)},
        {"rect": Rect2(80, 70, 416, 244), "color": Color(0.827451, 0.882353, 0.890196, 1)},
        {"rect": Rect2(126, 208, 324, 68), "color": Color(0.734314, 0.803922, 0.815686, 1)},
        {"rect": Rect2(94, 84, 42, 216), "color": Color(0.32549, 0.560784, 0.643137, 1)},
        {"rect": Rect2(440, 84, 42, 216), "color": Color(0.32549, 0.560784, 0.643137, 1)},
        {"rect": Rect2(224, 82, 128, 68), "color": Color(0.780392, 0.839216, 0.85098, 1)},
        {"rect": Rect2(376, 116, 74, 118), "color": Color(0.756863, 0.815686, 0.823529, 1)}
    ]


func get_overlay_rects() -> Array:
    return [
        {"rect": Rect2(238, 92, 100, 48), "color": Color(0.964706, 0.921569, 0.705882, 1)},
        {"rect": Rect2(252, 165, 72, 72), "color": Color(0.247059, 0.584314, 0.694118, 1)},
        {"rect": Rect2(392, 130, 40, 92), "color": Color(0.533333, 0.615686, 0.643137, 1)},
        {"rect": Rect2(144, 222, 288, 2), "color": Color(0.898039, 0.921569, 0.878431, 1)},
        {"rect": Rect2(160, 140, 256, 2), "color": Color(0.898039, 0.921569, 0.878431, 1)}
    ]


func get_circle_draws() -> Array:
    return [
        {"position": Vector2(288, 200), "radius": 22.0, "color": Color(0.788235, 0.937255, 0.972549, 0.55)},
        {"position": Vector2(288, 200), "radius": 12.0, "color": Color(0.92549, 0.984314, 1, 0.8)},
        {"position": Vector2(288, 116), "radius": 14.0, "color": Color(0.933333, 0.886275, 0.682353, 0.35)}
    ]


func get_line_draws() -> Array:
    return [
        {"from": Vector2(115, 118), "to": Vector2(115, 266), "color": Color(0.8, 0.929412, 0.968627, 0.65), "width": 2.0},
        {"from": Vector2(461, 118), "to": Vector2(461, 266), "color": Color(0.8, 0.929412, 0.968627, 0.65), "width": 2.0},
        {"from": Vector2(214, 242), "to": Vector2(362, 242), "color": Color(0.898039, 0.921569, 0.878431, 1), "width": 2.0}
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(48, 44, 480, 18),
        Rect2(48, 322, 480, 18),
        Rect2(48, 62, 18, 260),
        Rect2(510, 62, 18, 260),
        Rect2(144, 70, 18, 132),
        Rect2(414, 70, 18, 132),
        Rect2(188, 246, 200, 16)
    ]


func get_trigger_specs() -> Array:
    var primary_scene := get_primary_scene_record()
    var primary_scene_id := get_primary_scene_id()
    var primary_quest_id := get_primary_quest_id()
    var quest_info_lines := quest_lines(primary_quest_id, 3)
    var scene_info_lines := scene_lines(primary_scene_id, 3)
    var audience_lines := PackedStringArray()
    audience_lines.append_array(quest_info_lines)
    audience_lines.append_array(scene_info_lines)
    var speaker := "Palace Attendant"
    var prompt := "request entry"
    var participants: Array = primary_scene.get("participants", [])
    if participants is Array:
        if participants.has("Luka"):
            speaker = "Luka"
            prompt = "speak to Luka"
        elif participants.has("Archivist Neral"):
            speaker = "Archivist Neral"
            prompt = "request archive guidance"

    return [
        {
            "id": "luka_audience",
            "speaker": speaker,
            "prompt": prompt,
            "radius": 22.0,
            "position": Vector2(288, 118),
            "color": Color(0.972549, 0.878431, 0.643137, 0.95),
            "lines": audience_lines
        },
        {
            "id": "neral_archive",
            "speaker": "Archivist Neral",
            "prompt": "inspect archive pocket",
            "radius": 20.0,
            "position": Vector2(412, 180),
            "color": Color(0.603922, 0.792157, 0.87451, 0.95),
            "lines": PackedStringArray([
                "Location: %s" % str(primary_scene.get("location", "Water Palace inner chamber")),
                "Beat: %s" % str(primary_scene.get("narrative_beat", "The temple order is organized, strained, and not universally trusted.")),
                "Art focus: %s" % list_to_sentence(primary_scene.get("art_requirements", []))
            ])
        },
        {
            "id": "ritual_basin",
            "speaker": "Mana Basin",
            "prompt": "inspect the ritual basin",
            "radius": 18.0,
            "position": Vector2(288, 200),
            "color": Color(0.701961, 0.933333, 0.984314, 0.95),
            "lines": PackedStringArray([
                "Goal: %s" % str(primary_scene.get("player_goal", "Understand the immediate quest and the limits of what the palace can explain.")),
                "Play focus: %s" % list_to_sentence(primary_scene.get("gameplay_beat", [])),
                "The basin remains the benchmark VFX anchor for the Water Palace route."
            ])
        }
    ]
