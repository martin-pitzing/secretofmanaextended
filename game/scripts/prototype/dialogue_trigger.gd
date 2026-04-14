extends Area2D

class_name DialogueTrigger

signal dialogue_requested(speaker: String, lines: PackedStringArray)

var trigger_id := ""
var speaker := ""
var lines := PackedStringArray()
var prompt_text := "Inspect"
var radius := 18.0
var accent_color := Color(0.709804, 0.843137, 0.921569, 0.95)

var _pulse := 0.0
var _shape: CollisionShape2D


func configure(config: Dictionary) -> void:
    trigger_id = str(config.get("id", ""))
    speaker = str(config.get("speaker", ""))
    prompt_text = str(config.get("prompt", "Inspect"))
    radius = float(config.get("radius", 18.0))
    accent_color = config.get("color", accent_color)
    position = config.get("position", Vector2.ZERO)
    lines = _coerce_lines(config.get("lines", []))


func _ready() -> void:
    collision_layer = 4
    collision_mask = 0
    monitorable = true
    monitoring = false
    input_pickable = false

    _shape = CollisionShape2D.new()
    var circle := CircleShape2D.new()
    circle.radius = radius
    _shape.shape = circle
    add_child(_shape)

    set_process(true)
    queue_redraw()


func _process(delta: float) -> void:
    _pulse += delta
    queue_redraw()


func _draw() -> void:
    var ring_alpha := 0.18 + sin(_pulse * 2.0) * 0.04
    var inner_alpha := 0.24 + sin(_pulse * 2.0 + 0.5) * 0.05
    var ring_color := Color(accent_color.r, accent_color.g, accent_color.b, ring_alpha)
    var inner_color := Color(accent_color.r, accent_color.g, accent_color.b, inner_alpha)

    draw_circle(Vector2.ZERO, 5.0, inner_color)
    draw_arc(Vector2.ZERO, radius - 3.0, 0.0, TAU, 20, ring_color, 2.0)


func activate() -> void:
    dialogue_requested.emit(speaker, lines)


func get_prompt_text() -> String:
    return prompt_text


func _coerce_lines(raw_lines) -> PackedStringArray:
    var output := PackedStringArray()
    for value in raw_lines:
        output.append(str(value))
    return output
