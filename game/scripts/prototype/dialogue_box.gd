extends Control

class_name DialogueBox

signal closed

var _speaker := ""
var _lines := PackedStringArray()
var _index := 0

@onready var _speaker_label: Label = $Panel/Margin/VBox/Speaker
@onready var _body_label: Label = $Panel/Margin/VBox/Body
@onready var _continue_label: Label = $Panel/Margin/VBox/Continue


func _ready() -> void:
    _speaker_label.modulate = Color(0.898039, 0.870588, 0.658824, 1)
    _body_label.modulate = Color(0.929412, 0.933333, 0.913725, 1)
    _continue_label.modulate = Color(0.682353, 0.760784, 0.85098, 1)


func open_dialogue(speaker: String, lines: PackedStringArray) -> void:
    _speaker = speaker
    _lines = lines
    _index = 0
    visible = true
    _refresh()


func advance() -> void:
    if not visible:
        return

    _index += 1
    if _index >= _lines.size():
        hide_immediately()
        closed.emit()
        return

    _refresh()


func hide_immediately() -> void:
    visible = false
    _speaker = ""
    _lines = PackedStringArray()
    _index = 0


func is_open() -> bool:
    return visible


func _refresh() -> void:
    var current_line := ""
    if _lines.size() > 0:
        current_line = _lines[_index]

    _speaker_label.text = _speaker
    _body_label.text = current_line

    if _index >= _lines.size() - 1:
        _continue_label.text = "E / Enter: close"
    else:
        _continue_label.text = "E / Enter: continue"
