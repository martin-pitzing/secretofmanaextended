extends CharacterBody2D

class_name PrototypePlayer

signal interact_requested
signal prompt_changed(prompt: String)

@export var move_speed := 92.0

var controls_enabled := true
var facing := Vector2.DOWN

var _nearby_interactables := []
var _attack_cooldown_remaining := 0.0
var _attack_time_remaining := 0.0
var _hit_targets_this_swing := []

@onready var _body: Polygon2D = $Body
@onready var _facing_line: Line2D = $FacingLine
@onready var _attack_area: Area2D = $AttackArea
@onready var _slash_visual: Polygon2D = $AttackArea/SlashVisual
@onready var _interaction_sensor: Area2D = $InteractionSensor


func _ready() -> void:
    _interaction_sensor.area_entered.connect(_on_interaction_area_entered)
    _interaction_sensor.area_exited.connect(_on_interaction_area_exited)
    _attack_area.area_entered.connect(_on_attack_area_entered)
    _refresh_facing_visuals()
    _emit_prompt()


func _physics_process(delta: float) -> void:
    _tick_attack(delta)

    if not controls_enabled:
        velocity = Vector2.ZERO
        move_and_slide()
        return

    var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if input_vector != Vector2.ZERO:
        facing = _cardinalize(input_vector)
        velocity = input_vector.normalized() * move_speed
    else:
        velocity = Vector2.ZERO

    if _attack_time_remaining > 0.0:
        velocity *= 0.28

    move_and_slide()
    _refresh_facing_visuals()

    if Input.is_action_just_pressed("interact"):
        interact_requested.emit()

    if Input.is_action_just_pressed("attack"):
        _start_attack()


func set_controls_enabled(value: bool) -> void:
    controls_enabled = value
    if not value:
        velocity = Vector2.ZERO


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


func _refresh_facing_visuals() -> void:
    var direction := _cardinalize(facing)
    _facing_line.points = PackedVector2Array([direction * 2.0, direction * 14.0])

    if _attack_time_remaining > 0.0:
        _body.color = Color(0.980392, 0.894118, 0.615686, 1)
    else:
        _body.color = Color(0.843137, 0.831373, 0.756863, 1)


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
