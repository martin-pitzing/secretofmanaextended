extends "res://scripts/prototype/prototype_map.gd"

const Chapter1MapPrimitives = preload("res://scripts/prototype/maps/chapter1_map_primitives.gd")

var _palette := {
    "background": Color(0.054902, 0.0784314, 0.101961, 1),
    "wall": Color(0.141176, 0.172549, 0.188235, 1),
    "wall_outline": Color(0.301961, 0.34902, 0.372549, 1),
    "floor": Color(0.301961, 0.337255, 0.290196, 1),
    "lane": Color(0.470588, 0.427451, 0.317647, 1),
    "pod_potos": Color(0.470588, 0.396078, 0.298039, 1),
    "pod_palace": Color(0.623529, 0.709804, 0.745098, 1),
    "pod_pandora": Color(0.505882, 0.388235, 0.380392, 1),
    "pod_sprite": Color(0.635294, 0.592157, 0.447059, 1),
    "pod_combat": Color(0.352941, 0.329412, 0.262745, 1),
    "marker": Color(0.831373, 0.756863, 0.537255, 1),
    "line_soft": Color(0.756863, 0.694118, 0.54902, 0.8),
    "enemy_1": Color(0.854902, 0.529412, 0.392157, 1),
    "enemy_2": Color(0.94902, 0.611765, 0.419608, 1),
    "enemy_3": Color(0.772549, 0.470588, 0.356863, 1)
}


func get_map_id() -> String:
    return "ch01_character_sandbox"


func get_map_title() -> String:
    return "Chapter 1 Character Sandbox"


func get_map_subtitle() -> String:
    return "Locomotion, interaction, combat, and sprite-base review lane."


func get_status_text() -> String:
    if get_active_enemy_count() > 0:
        return "Sandbox live: clear %d active targets, then review NPC interaction and sprite stands." % get_active_enemy_count()
    return "Sandbox clear: test Chapter 1 interactions, character reads, and placeholder sprite hookups."


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 960, 540)


func get_spawn_position() -> Vector2:
    return Vector2(120, 428)


func get_background_color() -> Color:
    return _palette["background"]


func get_wall_color() -> Color:
    return _palette["wall"]


func get_wall_outline_color() -> Color:
    return _palette["wall_outline"]


func get_floor_rects() -> Array:
    return [
        Chapter1MapPrimitives.rect_fill(Rect2(36, 36, 888, 468), _palette["floor"]),
        Chapter1MapPrimitives.rect_fill(Rect2(82, 92, 224, 124), _palette["pod_potos"]),
        Chapter1MapPrimitives.rect_fill(Rect2(334, 92, 224, 124), _palette["pod_palace"]),
        Chapter1MapPrimitives.rect_fill(Rect2(586, 92, 286, 124), _palette["pod_pandora"]),
        Chapter1MapPrimitives.rect_fill(Rect2(82, 250, 356, 132), _palette["pod_sprite"]),
        Chapter1MapPrimitives.rect_fill(Rect2(474, 250, 398, 180), _palette["pod_combat"]),
        Chapter1MapPrimitives.rect_fill(Rect2(106, 420, 744, 18), _palette["lane"])
    ]


func get_overlay_rects() -> Array:
    var overlays := []
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(106, 114, 176, 24), _palette["marker"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(358, 114, 176, 24), _palette["marker"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(610, 114, 238, 24), _palette["marker"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(110, 272, 150, 24), _palette["marker"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(276, 272, 138, 24), _palette["marker"], 2.0))
    overlays.append(Chapter1MapPrimitives.rect_outline(Rect2(498, 272, 166, 24), _palette["marker"], 2.0))
    overlays.append_array(Chapter1MapPrimitives.crate_cluster([
        Rect2(686, 320, 42, 20),
        Rect2(734, 326, 28, 18),
        Rect2(770, 318, 36, 22)
    ], _palette["marker"], _palette["wall"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(146, 310, 40, 34), _palette["marker"]))
    overlays.append(Chapter1MapPrimitives.rect_fill(Rect2(316, 310, 34, 34), _palette["marker"]))
    return overlays


func get_circle_draws() -> Array:
    return [
        Chapter1MapPrimitives.circle_draw(Vector2(172, 158), 18.0, Color(0.760784, 0.843137, 0.909804, 0.16)),
        Chapter1MapPrimitives.circle_draw(Vector2(424, 158), 18.0, Color(0.85098, 0.941176, 0.964706, 0.18)),
        Chapter1MapPrimitives.circle_draw(Vector2(744, 158), 18.0, Color(0.92549, 0.729412, 0.592157, 0.16)),
        Chapter1MapPrimitives.circle_draw(Vector2(166, 326), 20.0, Color(0.980392, 0.847059, 0.611765, 0.16)),
        Chapter1MapPrimitives.circle_draw(Vector2(334, 326), 20.0, Color(0.980392, 0.847059, 0.611765, 0.16)),
        Chapter1MapPrimitives.circle_draw(Vector2(690, 354), 24.0, Color(0.980392, 0.733333, 0.509804, 0.16))
    ]


func get_line_draws() -> Array:
    return [
        Chapter1MapPrimitives.line_draw(Vector2(318, 92), Vector2(318, 216), _palette["line_soft"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(570, 92), Vector2(570, 216), _palette["line_soft"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(450, 250), Vector2(450, 430), _palette["line_soft"], 2.0),
        Chapter1MapPrimitives.line_draw(Vector2(118, 432), Vector2(838, 432), _palette["line_soft"], 3.0)
    ]


func get_wall_rects() -> Array:
    return [
        Rect2(36, 36, 888, 20),
        Rect2(36, 484, 888, 20),
        Rect2(36, 56, 20, 428),
        Rect2(904, 56, 20, 428),
        Rect2(82, 92, 224, 18),
        Rect2(334, 92, 224, 18),
        Rect2(586, 92, 286, 18),
        Rect2(82, 250, 356, 18),
        Rect2(474, 250, 398, 18),
        Rect2(474, 412, 398, 18),
        Rect2(628, 306, 18, 58),
        Rect2(804, 306, 18, 58)
    ]


func get_actor_specs() -> Array:
    return [
        {
            "id": "potos_villager",
            "speaker": "Potos Villager",
            "prompt": "talk to the villager",
            "position": Vector2(172, 170),
            "base_color": Color(0.784314, 0.67451, 0.545098, 1),
            "accent_color": Color(0.690196, 0.45098, 0.356863, 0.95),
            "sprite_path": "res://art/ch01/characters/potos_villager/sandbox_placeholder.png",
            "lines": PackedStringArray([
                "Potos is the home-read benchmark: warmth first, old ward culture second, fear under the floorboards third.",
                "Use this stand to test readable NPC interaction spacing and early-village costume language.",
                "Target sprite drop path: art/ch01/characters/potos_villager/sandbox_placeholder.png"
            ])
        },
        {
            "id": "water_palace_attendant",
            "speaker": "Water Palace Attendant",
            "prompt": "talk to the attendant",
            "position": Vector2(424, 170),
            "base_color": Color(0.796078, 0.870588, 0.901961, 1),
            "accent_color": Color(0.87451, 0.776471, 0.545098, 0.95),
            "sprite_path": "res://art/ch01/characters/water_palace_attendant/sandbox_placeholder.png",
            "lines": PackedStringArray([
                "Water Palace character reads should feel institutional, precise, and calm under strain.",
                "This stand is for robe silhouette, trim language, and temple-access hierarchy reads.",
                "Target sprite drop path: art/ch01/characters/water_palace_attendant/sandbox_placeholder.png"
            ])
        },
        {
            "id": "pandora_refugee",
            "speaker": "Pandora Refugee",
            "prompt": "talk to the refugee",
            "position": Vector2(744, 170),
            "base_color": Color(0.760784, 0.631373, 0.592157, 1),
            "accent_color": Color(0.901961, 0.709804, 0.560784, 0.95),
            "sprite_path": "res://art/ch01/characters/pandora_refugee/sandbox_placeholder.png",
            "lines": PackedStringArray([
                "Pandora civilians should read as displaced by systems, not generic fantasy peasants.",
                "Use this stand to test bag shapes, stress-wear, and civic-crisis palette contrast against the Chapter 1 lane.",
                "Target sprite drop path: art/ch01/characters/pandora_refugee/sandbox_placeholder.png"
            ])
        },
        {
            "id": "randi_sprite_stand",
            "speaker": "Hero Sprite Stand",
            "prompt": "inspect the hero stand",
            "position": Vector2(166, 336),
            "base_color": Color(0.886275, 0.839216, 0.694118, 1),
            "accent_color": Color(0.631373, 0.776471, 0.584314, 0.95),
            "sprite_path": "res://art/ch01/characters/randi/sandbox_placeholder.png",
            "lines": PackedStringArray([
                "Randi's base read should prove locomotion silhouette before detail density.",
                "Even placeholder sprites need clear head, torso, sword-hand, and run-direction readability.",
                "Target sprite drop path: art/ch01/characters/randi/sandbox_placeholder.png"
            ])
        },
        {
            "id": "rabite_sprite_stand",
            "speaker": "Cute Monster Stand",
            "prompt": "inspect the monster stand",
            "position": Vector2(334, 336),
            "base_color": Color(0.909804, 0.741176, 0.564706, 1),
            "accent_color": Color(0.768627, 0.458824, 0.372549, 0.95),
            "sprite_path": "res://art/ch01/characters/rabite_echo/sandbox_placeholder.png",
            "lines": PackedStringArray([
                "Cute monsters still need strong enemy silhouettes, anticipation, and hit readability.",
                "Use this stand to test how far softness can go before combat clarity collapses.",
                "Target sprite drop path: art/ch01/characters/rabite_echo/sandbox_placeholder.png"
            ])
        }
    ]


func get_enemy_specs() -> Array:
    return [
        {
            "position": Vector2(620, 354),
            "color": _palette["enemy_1"],
            "move_speed": 34.0,
            "idle_radius": 12.0,
            "aggro_radius": 110.0,
            "hit_points": 2
        },
        {
            "position": Vector2(700, 330),
            "color": _palette["enemy_2"],
            "move_speed": 36.0,
            "idle_radius": 10.0,
            "aggro_radius": 112.0,
            "hit_points": 2
        },
        {
            "position": Vector2(784, 360),
            "color": _palette["enemy_3"],
            "move_speed": 32.0,
            "idle_radius": 14.0,
            "aggro_radius": 108.0,
            "hit_points": 3
        }
    ]
