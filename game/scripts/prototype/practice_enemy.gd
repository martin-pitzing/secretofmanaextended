extends Area2D

class_name PracticeEnemy

signal defeated(enemy: PracticeEnemy)

@export var move_speed := 32.0
@export var aggro_radius := 118.0
@export var idle_radius := 18.0
@export var hit_points := 2
@export var base_color := Color(0.87451, 0.498039, 0.360784, 1)

var _player: Node2D
var _spawn_position := Vector2.ZERO
var _time := 0.0
var _flash_timer := 0.0

@onready var _body: Polygon2D = $Body
@onready var _eye: Line2D = $Eye


func _ready() -> void:
    collision_layer = 8
    collision_mask = 0
    monitorable = true
    monitoring = false
    input_pickable = false
    _spawn_position = global_position
    _apply_visuals()


func configure(player: Node2D) -> void:
    _player = player
    _apply_visuals()


func _process(delta: float) -> void:
    _time += delta
    _flash_timer = max(_flash_timer - delta, 0.0)
    _apply_visuals()

    var target := _spawn_position + Vector2(cos(_time * 0.85), sin(_time * 1.1)) * idle_radius
    if is_instance_valid(_player) and global_position.distance_to(_player.global_position) <= aggro_radius:
        target = _player.global_position

    global_position = global_position.move_toward(target, move_speed * delta)


func receive_hit(damage: int = 1, knockback := Vector2.ZERO) -> void:
    hit_points -= damage
    _flash_timer = 0.12

    if knockback != Vector2.ZERO:
        global_position += knockback.normalized() * 8.0

    if hit_points <= 0:
        defeated.emit(self)
        queue_free()


func _apply_visuals() -> void:
    if _flash_timer > 0.0:
        _body.color = Color(1, 0.952941, 0.870588, 1)
        _eye.default_color = Color(0.337255, 0.172549, 0.0862745, 1)
        scale = Vector2.ONE * 1.08
        return

    _body.color = base_color
    _eye.default_color = Color(0.168627, 0.145098, 0.196078, 1)
    scale = Vector2.ONE
