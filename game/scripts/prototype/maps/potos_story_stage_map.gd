extends "res://scripts/prototype/prototype_map.gd"

const Chapter1MapPrimitives = preload("res://scripts/prototype/maps/chapter1_map_primitives.gd")

var _palette := {
    "background": Color(0.0784314, 0.109804, 0.12549, 1),
    "wall": Color(0.219608, 0.192157, 0.14902, 1),
    "wall_outline": Color(0.403922, 0.360784, 0.290196, 1),
    "village_ground": Color(0.388235, 0.372549, 0.294118, 1),
    "village_square": Color(0.505882, 0.470588, 0.360784, 1),
    "house_floor": Color(0.564706, 0.470588, 0.329412, 1),
    "river_bank": Color(0.25098, 0.454902, 0.552941, 1),
    "cedar_light": Color(0.490196, 0.360784, 0.25098, 1),
    "cedar_dark": Color(0.419608, 0.301961, 0.203922, 1),
    "cloth": Color(0.643137, 0.447059, 0.356863, 1),
    "cloth_trim": Color(0.854902, 0.780392, 0.560784, 1),
    "linen": Color(0.792157, 0.760784, 0.603922, 1),
    "ward_stone": Color(0.619608, 0.670588, 0.615686, 1),
    "path_mark": Color(0.631373, 0.741176, 0.772549, 0.55),
    "river_glow": Color(0.631373, 0.858824, 0.929412, 0.18),
    "lantern_glow": Color(0.94902, 0.815686, 0.552941, 0.15),
    "judgment_mark": Color(0.733333, 0.509804, 0.423529, 0.8),
    "crowd_glow": Color(0.92549, 0.658824, 0.490196, 0.14),
    "trigger_home": Color(0.909804, 0.768627, 0.482353, 0.95),
    "trigger_shrine": Color(0.631373, 0.803922, 0.921569, 0.95),
    "trigger_route": Color(0.968627, 0.843137, 0.52549, 0.95),
    "trigger_crowd": Color(0.921569, 0.690196, 0.47451, 0.95),
    "trigger_echo": Color(0.701961, 0.741176, 0.870588, 0.95)
}


func get_map_id() -> String:
    return "potos_story_stage"


func get_map_title() -> String:
    var scene := get_primary_scene_record()
    if scene.is_empty():
        return "Potos Story Stage"
    return "%s Stage" % scene.get("title", "Potos Story Stage")


func get_map_subtitle() -> String:
    var scene := get_primary_scene_record()
    var quest := get_primary_quest_record()
    var quest_title := str(quest.get("title", "Quest"))
    var location := str(scene.get("location", "Potos village and river edge"))
    return "%s | %s." % [quest_title, location]


func get_status_text() -> String:
    if _is_judgment_scene():
        return "Potos has turned its square into a public judgment ring."
    return get_map_subtitle()


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 704, 416)


func get_spawn_position() -> Vector2:
    if _is_judgment_scene():
        return Vector2(154, 294)
    return Vector2(122, 314)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    var floors := [
        Chapter1MapPrimitives.rect_fill(Rect2(40, 40, 624, 336), _palette["village_ground"]),
        Chapter1MapPrimitives.rect_fill(Rect2(72, 76, 170, 106), _palette["house_floor"]),
        Chapter1MapPrimitives.rect_fill(Rect2(264, 74, 198, 116), _palette["village_square"]),
        Chapter1MapPrimitives.rect_fill(Rect2(500, 88, 106, 90), _palette["house_floor"]),
        Chapter1MapPrimitives.rect_fill(Rect2(86, 212, 172, 108), _palette["river_bank"]),
        Chapter1MapPrimitives.rect_fill(Rect2(270, 230, 284, 88), _palette["village_square"]),
        Chapter1MapPrimitives.rect_fill(Rect2(108, 336, 220, 16), _palette["cedar_light"]),
        Chapter1MapPrimitives.rect_fill(Rect2(346, 336, 180, 16), _palette["cedar_dark"])
    ]

    if _is_judgment_scene():
        floors.append(Chapter1MapPrimitives.rect_fill(Rect2(278, 108, 170, 86), _palette["judgment_mark"]))

    return floors


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append_array(Chapter1MapPrimitives.cloth_strip(Rect2(106, 94, 108, 16), _palette["cloth"], _palette["cloth_trim"], 4.0))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(128, 238, 88, 26), _palette["linen"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(156, 108, 26, 42), _palette["linen"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(498, 104, 30, 50), _palette["cloth"]))
    overlays.append_array(Chapter1MapPrimitives.crate_cluster([
        Rect2(290, 248, 42, 18),
        Rect2(340, 248, 32, 22),
        Rect2(378, 258, 28, 18)
    ], _palette["cedar_light"], _palette["cedar_dark"]))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(104, 240, 118, 36), _palette["ward_stone"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(110, 250, 12, 12), _palette["ward_stone"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(204, 250, 12, 12), _palette["ward_stone"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(464, 238, 72, 44), _palette["cedar_dark"]))

    if _is_judgment_scene():
        overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(298, 122, 130, 56), _palette["linen"], 2.0))
        overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(330, 120, 18, 74), _palette["judgment_mark"]))
        overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(376, 120, 18, 74), _palette["judgment_mark"]))
        overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(278, 212, 22, 18), _palette["cedar_dark"]))
        overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(426, 212, 22, 18), _palette["cedar_dark"]))

    return overlays


func get_circle_draws() -> Array:
    var circles := [
        Chapter1MapPrimitives.circle_draw(Vector2(166, 254), 18.0, _palette["river_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(170, 118), 16.0, _palette["lantern_glow"]),
        Chapter1MapPrimitives.circle_draw(Vector2(522, 122), 14.0, _palette["lantern_glow"])
    ]

    if _is_judgment_scene():
        circles.append(Chapter1MapPrimitives.circle_draw(Vector2(362, 152), 20.0, _palette["crowd_glow"]))

    return circles


func get_line_draws() -> Array:
    var lines := [
        Chapter1MapPrimitives.line_draw(Vector2(248, 86), Vector2(248, 352), _palette["path_mark"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(108, 344), Vector2(544, 344), _palette["path_mark"], 3.0),
        Chapter1MapPrimitives.line_draw(Vector2(106, 204), Vector2(230, 204), _palette["path_mark"], 2.0)
    ]

    if _is_judgment_scene():
        lines.append(Chapter1MapPrimitives.line_draw(Vector2(286, 208), Vector2(286, 244), _palette["judgment_mark"], 2.0))
        lines.append(Chapter1MapPrimitives.line_draw(Vector2(438, 208), Vector2(438, 244), _palette["judgment_mark"], 2.0))
        lines.append(Chapter1MapPrimitives.line_draw(Vector2(286, 244), Vector2(438, 244), _palette["judgment_mark"], 2.0))

    return lines


func get_wall_rects() -> Array:
    return [
        Rect2(40, 40, 624, 18),
        Rect2(40, 358, 624, 18),
        Rect2(40, 58, 18, 300),
        Rect2(646, 58, 18, 300),
        Rect2(72, 76, 170, 18),
        Rect2(72, 94, 18, 92),
        Rect2(224, 94, 18, 92),
        Rect2(72, 168, 54, 18),
        Rect2(162, 168, 80, 18),
        Rect2(500, 88, 106, 18),
        Rect2(500, 106, 18, 74),
        Rect2(588, 106, 18, 74),
        Rect2(500, 162, 28, 18),
        Rect2(552, 162, 54, 18),
        Rect2(86, 212, 18, 110),
        Rect2(240, 212, 18, 110),
        Rect2(86, 304, 54, 18),
        Rect2(176, 304, 82, 18),
        Rect2(464, 236, 18, 52),
        Rect2(518, 236, 18, 52)
    ]


func get_trigger_specs() -> Array:
    var scene := get_primary_scene_record()
    var scene_id := get_primary_scene_id()
    var scene_info_lines := scene_lines(scene_id, 3)
    var exit_condition := str(scene.get("exit_condition", "Move deeper into the Chapter 1 route."))

    if _is_judgment_scene():
        return [
            {
                "id": "judgment_ring",
                "speaker": "Village Judgment Ring",
                "prompt": "face the accusation",
                "radius": 22.0,
                "position": Vector2(362, 150),
                "color": _palette["trigger_crowd"],
                "lines": PackedStringArray([
                    "Fear organizes faster than truth once the seal breaks.",
                    "The same square that held daily life now holds a public refusal to protect Randi."
                ]),
                "completes_scene": true,
                "completion_status": "Potos has finished turning fear into exile.",
                "completion_lines": [
                    "Exit condition: %s" % exit_condition,
                    "The village square now reads as the place where home and punishment became the same space."
                ]
            },
            {
                "id": "shrine_voice",
                "speaker": "Shrine Messenger",
                "prompt": "hear the shrine warning",
                "radius": 18.0,
                "position": Vector2(178, 250),
                "color": _palette["trigger_shrine"],
                "lines": PackedStringArray([
                    "The falls were a containment site before they became a taboo.",
                    "No one in the crowd has enough authority left to say that out loud cleanly."
                ])
            },
            {
                "id": "boundary_staff",
                "speaker": "Boundary Staff",
                "prompt": "read the exile marker",
                "radius": 18.0,
                "position": Vector2(520, 256),
                "color": _palette["trigger_echo"],
                "lines": PackedStringArray(scene_info_lines)
            }
        ]

    return [
        {
            "id": "door_charms",
            "speaker": "Village Lintel",
            "prompt": "inspect the ward charms",
            "radius": 18.0,
            "position": Vector2(170, 120),
            "color": _palette["trigger_home"],
            "lines": PackedStringArray([
                "Potos reads as ordinary because its protective habits have become part of domestic routine.",
                "Door charms, rope knots, and carved stones still point back to old fear even before anyone speaks about the falls."
            ])
        },
        {
            "id": "river_shrine",
            "speaker": "River Shrine Stone",
            "prompt": "read the river wards",
            "radius": 18.0,
            "position": Vector2(166, 252),
            "color": _palette["trigger_shrine"],
            "lines": PackedStringArray([
                "The river edge still carries flood marks, ward signs, and half-remembered instructions.",
                "Potos feels warm because its caution has been absorbed into daily life."
            ])
        },
        {
            "id": "boys_route",
            "speaker": "Village Boys",
            "prompt": "follow the boys to the falls",
            "radius": 20.0,
            "position": Vector2(510, 258),
            "color": _palette["trigger_route"],
            "lines": PackedStringArray(scene_info_lines),
            "completes_scene": true,
            "completion_status": "The route out of Potos now carries you toward the forbidden site.",
            "completion_lines": [
                "Exit condition: %s" % exit_condition,
                "The village's ordinary route markers already point away from the falls, which makes following the boys feel like stepping past inherited caution."
            ]
        }
    ]


func _is_judgment_scene() -> bool:
    return get_primary_scene_id() == "ch01_sc03_judgment_at_potos"
