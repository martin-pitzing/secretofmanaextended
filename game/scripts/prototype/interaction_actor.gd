extends Area2D

class_name PrototypeInteractionActor

signal interaction_requested(payload: Dictionary)

var actor_id := ""
var speaker := ""
var prompt_text := "Talk"
var accent_color := Color(0.705882, 0.847059, 0.921569, 0.95)
var base_color := Color(0.788235, 0.760784, 0.682353, 1)
var sprite_path := ""
var sprite_scale := Vector2.ONE
var sprite_offset := Vector2.ZERO
var facing := Vector2.DOWN

var _pulse := 0.0
var _config: Dictionary = {}

@onready var _shape: CollisionShape2D = $CollisionShape2D
@onready var _shadow: Polygon2D = $Shadow
@onready var _body: Polygon2D = $Body
@onready var _accent: Polygon2D = $Accent
@onready var _facing_line: Line2D = $FacingLine
@onready var _sprite: Sprite2D = $VisualSprite


func configure(config: Dictionary) -> void:
    _config = config.duplicate(true)
    actor_id = str(config.get("id", ""))
    speaker = str(config.get("speaker", "Resident"))
    prompt_text = str(config.get("prompt", "Talk"))
    accent_color = config.get("accent_color", accent_color)
    base_color = config.get("base_color", base_color)
    sprite_path = str(config.get("sprite_path", ""))
    sprite_scale = config.get("sprite_scale", Vector2.ONE)
    sprite_offset = config.get("sprite_offset", Vector2.ZERO)
    position = config.get("position", Vector2.ZERO)
    facing = config.get("facing", Vector2.DOWN)


func _ready() -> void:
    collision_layer = 4
    collision_mask = 0
    monitorable = true
    monitoring = false
    input_pickable = false

    var circle := CircleShape2D.new()
    circle.radius = 16.0
    _shape.shape = circle

    _apply_visuals()
    set_process(true)
    queue_redraw()


func _process(delta: float) -> void:
    _pulse += delta
    queue_redraw()


func _draw() -> void:
    var ring_alpha := 0.14 + sin(_pulse * 2.0) * 0.03
    var inner_alpha := 0.18 + sin(_pulse * 2.0 + 0.5) * 0.04
    var ring_color := Color(accent_color.r, accent_color.g, accent_color.b, ring_alpha)
    var inner_color := Color(accent_color.r, accent_color.g, accent_color.b, inner_alpha)

    draw_circle(Vector2(0, 12), 6.0, inner_color)
    draw_arc(Vector2(0, 12), 15.0, 0.0, TAU, 24, ring_color, 2.0)


func activate() -> void:
    interaction_requested.emit(_config)


func get_prompt_text() -> String:
    return prompt_text


func _apply_visuals() -> void:
    _body.color = base_color
    _accent.color = accent_color
    _facing_line.default_color = Color(0.207843, 0.223529, 0.301961, 1)

    var direction := _cardinalize(facing)
    _facing_line.points = PackedVector2Array([Vector2(0, -2), Vector2(direction.x * 8.0, -2 + direction.y * 10.0)])

    _sprite.visible = false
    _sprite.texture = null
    _sprite.position = sprite_offset
    _sprite.scale = sprite_scale
    if sprite_path.is_empty():
        return
    if not ResourceLoader.exists(sprite_path):
        return

    var loaded_texture = load(sprite_path)
    if loaded_texture is Texture2D:
        _sprite.texture = loaded_texture
        _sprite.visible = true
        _body.visible = false
        _accent.visible = false
    else:
        _body.visible = true
        _accent.visible = true


func _cardinalize(direction: Vector2) -> Vector2:
    if abs(direction.x) > abs(direction.y):
        return Vector2(sign(direction.x), 0.0)
    return Vector2(0.0, sign(direction.y))
