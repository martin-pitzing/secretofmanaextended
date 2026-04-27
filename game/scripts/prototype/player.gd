extends CharacterBody2D

class_name PrototypePlayer

signal interact_requested
signal prompt_changed(prompt: String)

enum MotionState {
    IDLE,
    WALK,
    RUN,
    ATTACK_WINDUP,
    ATTACK_ACTIVE,
    ATTACK_RECOVERY,
    JUMP_START,
    JUMP_AIR,
    JUMP_LAND,
    HIT,
    INTERACT
}

@export var walk_speed := 92.0
@export var run_speed := 136.0
@export var run_double_tap_window := 0.24
@export var prefer_sprite_visual := true

var controls_enabled := true
var facing := Vector2.DOWN

var _nearby_interactables := []
var _attack_cooldown_remaining := 0.0
var _attack_time_remaining := 0.0
var _hit_targets_this_swing := []
var _motion_state := MotionState.IDLE
var _run_tap_direction := Vector2.ZERO
var _run_tap_remaining := 0.0
var _run_direction := Vector2.ZERO
var _run_active := false

@onready var _visual = $PlayerVisual
@onready var _attack_area: Area2D = $AttackArea
@onready var _slash_visual: Polygon2D = $AttackArea/SlashVisual
@onready var _interaction_sensor: Area2D = $InteractionSensor


func _ready() -> void:
    _interaction_sensor.area_entered.connect(_on_interaction_area_entered)
    _interaction_sensor.area_exited.connect(_on_interaction_area_exited)
    _attack_area.area_entered.connect(_on_attack_area_entered)
    _visual.set_prefer_sprite_visual(prefer_sprite_visual)
    _refresh_visuals()
    _emit_prompt()


func _physics_process(delta: float) -> void:
    _tick_attack(delta)
    _tick_run_window(delta)
    _capture_run_taps()

    if not controls_enabled:
        velocity = Vector2.ZERO
        _run_active = false
        _run_direction = Vector2.ZERO
        _set_motion_state(MotionState.IDLE)
        move_and_slide()
        _refresh_visuals()
        return

    var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    _update_run_state(input_vector)

    if input_vector != Vector2.ZERO:
        facing = _cardinalize(input_vector)
        var active_speed := run_speed if _run_active else walk_speed
        velocity = input_vector.normalized() * active_speed
    else:
        velocity = Vector2.ZERO

    if _attack_time_remaining > 0.0:
        velocity *= 0.28

    move_and_slide()
    _update_motion_state(input_vector)
    _refresh_visuals()

    if Input.is_action_just_pressed("interact"):
        interact_requested.emit()

    if Input.is_action_just_pressed("attack"):
        _start_attack()


func set_controls_enabled(value: bool) -> void:
    controls_enabled = value
    if not value:
        velocity = Vector2.ZERO
        _run_active = false
        _run_direction = Vector2.ZERO
        _set_motion_state(MotionState.IDLE)
        _refresh_visuals()


func get_current_interactable():
    var best_candidate = null
    var best_distance := INF

    for candidate in _nearby_interactables:
        if not is_instance_valid(candidate):
            continue
        var distance := global_position.distance_to(candidate.global_position)
        if distance < best_distance:
            best_candidate = candidate
            best_distance = distance

    return best_candidate


func clear_interactables() -> void:
    _nearby_interactables.clear()
    _emit_prompt()


func get_motion_state_name() -> String:
    match _motion_state:
        MotionState.IDLE:
            return "idle"
        MotionState.WALK:
            return "walk"
        MotionState.RUN:
            return "run"
        MotionState.ATTACK_WINDUP:
            return "attack_windup"
        MotionState.ATTACK_ACTIVE:
            return "attack_active"
        MotionState.ATTACK_RECOVERY:
            return "attack_recovery"
        MotionState.JUMP_START:
            return "jump_start"
        MotionState.JUMP_AIR:
            return "jump_air"
        MotionState.JUMP_LAND:
            return "jump_land"
        MotionState.HIT:
            return "hit"
        MotionState.INTERACT:
            return "interact"
        _:
            return "idle"


func _start_attack() -> void:
    if not controls_enabled or _attack_cooldown_remaining > 0.0:
        return

    var direction := _cardinalize(facing)
    _attack_cooldown_remaining = 0.32
    _attack_time_remaining = 0.11
    _hit_targets_this_swing.clear()
    _attack_area.monitoring = true
    _attack_area.position = direction * 20.0
    _attack_area.rotation = direction.angle()
    _slash_visual.visible = true
    _set_motion_state(MotionState.ATTACK_ACTIVE)
    _refresh_visuals()


func _tick_attack(delta: float) -> void:
    _attack_cooldown_remaining = max(_attack_cooldown_remaining - delta, 0.0)

    if _attack_time_remaining <= 0.0:
        return

    _attack_time_remaining = max(_attack_time_remaining - delta, 0.0)
    if _attack_time_remaining == 0.0:
        _attack_area.monitoring = false
        _attack_area.position = Vector2.ZERO
        _attack_area.rotation = 0.0
        _slash_visual.visible = false
        if velocity == Vector2.ZERO:
            _set_motion_state(MotionState.IDLE)

func _refresh_visuals() -> void:
    _visual.update_motion(_motion_state_to_visual_name(), facing, _attack_time_remaining > 0.0)


func _cardinalize(direction: Vector2) -> Vector2:
    if abs(direction.x) > abs(direction.y):
        return Vector2(sign(direction.x), 0.0)
    return Vector2(0.0, sign(direction.y))


func _on_interaction_area_entered(area: Area2D) -> void:
    if _nearby_interactables.has(area):
        return
    _nearby_interactables.append(area)
    _emit_prompt()


func _on_interaction_area_exited(area: Area2D) -> void:
    _nearby_interactables.erase(area)
    _emit_prompt()


func _on_attack_area_entered(area: Area2D) -> void:
    if _hit_targets_this_swing.has(area):
        return
    if area.has_method("receive_hit"):
        area.receive_hit(1, facing)
        _hit_targets_this_swing.append(area)


func _emit_prompt() -> void:
    var prompt := ""
    var interactable = get_current_interactable()
    if interactable and interactable.has_method("get_prompt_text"):
        prompt = "E / Enter: %s" % interactable.get_prompt_text()
    prompt_changed.emit(prompt)


func _tick_run_window(delta: float) -> void:
    _run_tap_remaining = max(_run_tap_remaining - delta, 0.0)
    if _run_tap_remaining == 0.0:
        _run_tap_direction = Vector2.ZERO


func _capture_run_taps() -> void:
    _capture_run_tap("move_left", Vector2.LEFT)
    _capture_run_tap("move_right", Vector2.RIGHT)
    _capture_run_tap("move_up", Vector2.UP)
    _capture_run_tap("move_down", Vector2.DOWN)


func _capture_run_tap(action_name: String, direction: Vector2) -> void:
    if not Input.is_action_just_pressed(action_name):
        return

    if _run_tap_remaining > 0.0 and direction == _run_tap_direction:
        _run_direction = direction
        _run_active = true
        _run_tap_remaining = 0.0
        _run_tap_direction = Vector2.ZERO
        return

    _run_tap_direction = direction
    _run_tap_remaining = run_double_tap_window


func _update_run_state(input_vector: Vector2) -> void:
    if input_vector == Vector2.ZERO:
        _run_active = false
        _run_direction = Vector2.ZERO
        return

    var move_direction := _cardinalize(input_vector)
    if _run_direction == Vector2.ZERO:
        _run_active = false
        return

    if move_direction != _run_direction or not _is_direction_action_pressed(_run_direction):
        _run_active = false
        _run_direction = Vector2.ZERO
        return

    _run_active = true


func _is_direction_action_pressed(direction: Vector2) -> bool:
    if direction == Vector2.LEFT:
        return Input.is_action_pressed("move_left")
    if direction == Vector2.RIGHT:
        return Input.is_action_pressed("move_right")
    if direction == Vector2.UP:
        return Input.is_action_pressed("move_up")
    if direction == Vector2.DOWN:
        return Input.is_action_pressed("move_down")
    return false


func _update_motion_state(input_vector: Vector2) -> void:
    if _attack_time_remaining > 0.0:
        _set_motion_state(MotionState.ATTACK_ACTIVE)
        return

    if input_vector == Vector2.ZERO:
        _set_motion_state(MotionState.IDLE)
        return

    if _run_active:
        _set_motion_state(MotionState.RUN)
        return

    _set_motion_state(MotionState.WALK)


func _set_motion_state(next_state: int) -> void:
    _motion_state = next_state


func _motion_state_to_visual_name() -> String:
    match _motion_state:
        MotionState.RUN:
            return "run"
        MotionState.WALK:
            return "walk"
        _:
            return "idle"
