extends Node2D

class_name PrototypePlayerVisual

const HERO_FRAME_ROOT := "res://art/ch01/characters/randi/hero"
const HERO_ANIMATIONS := {
    "idle_down": 2,
    "idle_up": 2,
    "idle_side": 2,
    "walk_down": 4,
    "walk_up": 4,
    "walk_side": 4,
    "run_down": 4,
    "run_up": 4,
    "run_side": 4
}
const HERO_ANIMATION_FPS := {
    "idle": 2.0,
    "walk": 7.0,
    "run": 11.0
}

@export var prefer_sprite_visual := true

var _hero_frames_ready := false

@onready var _fallback_root: Node2D = $FallbackRoot
@onready var _body: Polygon2D = $FallbackRoot/Body
@onready var _facing_line: Line2D = $FallbackRoot/FacingLine
@onready var _sprite_root: Node2D = $SpriteRoot
@onready var _hero_sprite: AnimatedSprite2D = $SpriteRoot/HeroSprite


func _ready() -> void:
    _hero_sprite.centered = true
    _hero_frames_ready = _load_hero_frames()
    _refresh_visual_mode()


func set_prefer_sprite_visual(value: bool) -> void:
    prefer_sprite_visual = value
    _refresh_visual_mode()


func has_hero_frames() -> bool:
    return _hero_frames_ready


func update_motion(state_name: String, facing: Vector2, attacking: bool = false) -> void:
    var direction := _cardinalize(facing)
    var direction_name := _direction_to_name(direction)
    var animation_name := "%s_%s" % [state_name, direction_name]
    var use_sprite := prefer_sprite_visual and _hero_frames_ready and _hero_sprite.sprite_frames and _hero_sprite.sprite_frames.has_animation(animation_name)

    _fallback_root.visible = not use_sprite
    _sprite_root.visible = use_sprite

    if use_sprite:
        _hero_sprite.flip_h = direction_name == "side" and direction.x < 0.0
        _hero_sprite.modulate = Color(1.0, 0.95, 0.86, 1.0) if attacking else Color.WHITE
        if _hero_sprite.animation != animation_name:
            _hero_sprite.play(animation_name)
        else:
            _hero_sprite.play()
        _hero_sprite.speed_scale = _speed_scale_for_state(state_name)
    else:
        _apply_fallback(direction, attacking)


func _refresh_visual_mode() -> void:
    var use_sprite := prefer_sprite_visual and _hero_frames_ready
    _fallback_root.visible = not use_sprite
    _sprite_root.visible = use_sprite


func _apply_fallback(direction: Vector2, attacking: bool) -> void:
    _facing_line.points = PackedVector2Array([direction * 2.0, direction * 14.0])
    _body.color = Color(0.980392, 0.894118, 0.615686, 1.0) if attacking else Color(0.843137, 0.831373, 0.756863, 1.0)


func _load_hero_frames() -> bool:
    var sprite_frames := SpriteFrames.new()
    var loaded_any := false

    for animation_name in HERO_ANIMATIONS.keys():
        sprite_frames.add_animation(animation_name)
        sprite_frames.set_animation_loop(animation_name, true)

        var animation_parts: PackedStringArray = animation_name.split("_", false, 1)
        var state_name: String = animation_parts[0]
        sprite_frames.set_animation_speed(animation_name, HERO_ANIMATION_FPS.get(state_name, 6.0))

        var frame_total: int = HERO_ANIMATIONS[animation_name]
        for frame_index in range(frame_total):
            var frame_path := "%s/%s_%d.png" % [HERO_FRAME_ROOT, animation_name, frame_index]
            if not ResourceLoader.exists(frame_path):
                continue
            var texture = load(frame_path)
            if texture is Texture2D:
                sprite_frames.add_frame(animation_name, texture)
                loaded_any = true

        if sprite_frames.get_frame_count(animation_name) == 0:
            sprite_frames.remove_animation(animation_name)

    if not loaded_any:
        _hero_sprite.sprite_frames = null
        return false

    _hero_sprite.sprite_frames = sprite_frames
    return true


func _direction_to_name(direction: Vector2) -> String:
    if abs(direction.x) > abs(direction.y):
        return "side"
    if direction.y < 0.0:
        return "up"
    return "down"


func _speed_scale_for_state(state_name: String) -> float:
    match state_name:
        "idle":
            return 1.0
        "walk":
            return 1.0
        "run":
            return 1.15
        _:
            return 1.0


func _cardinalize(direction: Vector2) -> Vector2:
    if abs(direction.x) > abs(direction.y):
        return Vector2(sign(direction.x), 0.0)
    if direction.y == 0.0:
        return Vector2.DOWN
    return Vector2(0.0, sign(direction.y))
