extends Area2D

class_name PrototypeMonster

## Animated monster spawned from a Ludo-generated SpriteFrames atlas.
##
## Lane convention follows the manifests under data/pipelines/monsters/:
## {state}_{direction} where state ∈ {idle, walk, attack, hurt, defeat}
## and direction ∈ {down, side}. Side lanes are flipped horizontally for
## left-facing motion. Lanes that don't exist in the .tres fall back to a
## reasonable substitute (e.g. attack_down → attack_side).

signal defeated(monster: PrototypeMonster)

enum State { IDLE, WALK, ATTACK, HURT, DEFEAT }

@export var monster_id := "rabite"
@export var sprite_frames_path := "res://art/monsters/forbidden_falls/rabite/rabite.tres"
@export var move_speed := 32.0
@export var aggro_radius := 118.0
@export var idle_radius := 18.0
@export var hit_points := 6
@export var attack_radius := 20.0
@export var attack_cooldown := 1.4
@export var hurt_duration := 0.35

var _player: Node2D
var _spawn_position := Vector2.ZERO
var _state := State.IDLE
var _facing := Vector2.DOWN
var _state_timer := 0.0
var _attack_cooldown_remaining := 0.0
var _patrol_time := 0.0

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
    collision_layer = 8
    collision_mask = 0
    monitorable = true
    monitoring = false
    input_pickable = false
    _spawn_position = global_position

    var frames := load(sprite_frames_path)
    if frames is SpriteFrames:
        _sprite.sprite_frames = frames
    else:
        push_warning("PrototypeMonster '%s' could not load SpriteFrames at %s" % [monster_id, sprite_frames_path])

    _enter_state(State.IDLE)


func configure(player: Node2D) -> void:
    _player = player


func _process(delta: float) -> void:
    _state_timer += delta
    _attack_cooldown_remaining = max(_attack_cooldown_remaining - delta, 0.0)

    match _state:
        State.IDLE, State.WALK:
            _tick_patrol_or_chase(delta)
        State.ATTACK:
            if _state_timer >= _sprite_anim_length():
                _enter_state(State.IDLE)
        State.HURT:
            if _state_timer >= hurt_duration:
                _enter_state(State.IDLE)
        State.DEFEAT:
            if _state_timer >= _sprite_anim_length():
                queue_free()


func receive_hit(damage: int = 1, knockback := Vector2.ZERO) -> void:
    if _state == State.DEFEAT:
        return
    hit_points -= damage
    if knockback != Vector2.ZERO:
        global_position += knockback.normalized() * 8.0
    if hit_points <= 0:
        _enter_state(State.DEFEAT)
        defeated.emit(self)
    else:
        _enter_state(State.HURT)


func _tick_patrol_or_chase(delta: float) -> void:
    _patrol_time += delta
    var target := _spawn_position + Vector2(cos(_patrol_time * 0.85), sin(_patrol_time * 1.1)) * idle_radius
    var chasing := false
    if is_instance_valid(_player) and global_position.distance_to(_player.global_position) <= aggro_radius:
        target = _player.global_position
        chasing = true

    if chasing and global_position.distance_to(_player.global_position) <= attack_radius and _attack_cooldown_remaining <= 0.0:
        _face_toward(_player.global_position)
        _enter_state(State.ATTACK)
        return

    var to_target := target - global_position
    if to_target.length() > 1.0:
        var step := to_target.normalized() * move_speed * delta
        global_position += step
        _face_from_velocity(step)
        if _state != State.WALK:
            _enter_state(State.WALK)
    else:
        if _state != State.IDLE:
            _enter_state(State.IDLE)


func _enter_state(new_state: int) -> void:
    _state = new_state
    _state_timer = 0.0
    if new_state == State.ATTACK:
        _attack_cooldown_remaining = attack_cooldown
    _play_for_state()


func _play_for_state() -> void:
    if _sprite == null or _sprite.sprite_frames == null:
        return
    var lane := _resolve_lane()
    if lane.is_empty():
        return
    if _sprite.animation != lane or not _sprite.is_playing():
        _sprite.play(lane)
    _sprite.flip_h = _facing.x < -0.01


func _resolve_lane() -> String:
    var state_name := _state_name()
    var dir_name := "side" if abs(_facing.x) > abs(_facing.y) else ("down" if _facing.y >= 0.0 else "up")
    var sf := _sprite.sprite_frames
    var candidates := [
        "%s_%s" % [state_name, dir_name],
        "%s_side" % state_name,
        "%s_down" % state_name,
        "idle_down",
    ]
    for candidate in candidates:
        if sf.has_animation(candidate):
            return candidate
    return ""


func _state_name() -> String:
    match _state:
        State.WALK: return "walk"
        State.ATTACK: return "attack"
        State.HURT: return "hurt"
        State.DEFEAT: return "defeat"
        _: return "idle"


func _face_from_velocity(velocity: Vector2) -> void:
    if velocity.length_squared() < 0.0001:
        return
    if abs(velocity.x) > abs(velocity.y):
        _facing = Vector2(sign(velocity.x), 0.0)
    else:
        _facing = Vector2(0.0, sign(velocity.y))


func _face_toward(point: Vector2) -> void:
    _face_from_velocity(point - global_position)


func _sprite_anim_length() -> float:
    if _sprite == null or _sprite.sprite_frames == null:
        return 0.4
    var lane := _sprite.animation
    if lane == &"" or not _sprite.sprite_frames.has_animation(lane):
        return 0.4
    var frame_count: int = _sprite.sprite_frames.get_frame_count(lane)
    var fps: float = _sprite.sprite_frames.get_animation_speed(lane)
    if fps <= 0.0 or frame_count <= 0:
        return 0.4
    return float(frame_count) / fps
