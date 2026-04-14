extends Node2D

const PrototypeInput = preload("res://scripts/prototype/prototype_input.gd")
const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")

const MAPS := [
    {
        "title": "Test Hall",
        "scene": preload("res://scenes/prototype/maps/test_room.tscn"),
        "scene_ids": ["ch02_sc06_kroll_offer"],
        "quest_ids": ["q_ch02_003_witness_the_terms_of_peace"]
    },
    {
        "title": "Water Palace",
        "scene": preload("res://scenes/prototype/maps/water_palace_benchmark.tscn"),
        "scene_ids": ["ch01_sc05_water_palace_approach", "ch01_sc06_luka_charge"],
        "quest_ids": ["q_ch01_003_seek_water_palace"]
    },
    {
        "title": "Forbidden Falls",
        "scene": preload("res://scenes/prototype/maps/forbidden_falls_benchmark.tscn"),
        "scene_ids": ["ch01_sc02_forbidden_falls"],
        "quest_ids": ["q_ch01_001_leave_potos"]
    }
]

var _current_map_index := 0
var _current_map
var _content_repository

@onready var _map_root: Node2D = $MapRoot
@onready var _player = $Player
@onready var _camera: Camera2D = $Player/Camera2D
@onready var _map_label: Label = $CanvasLayer/TopBar/TopMargin/TopVBox/MapLabel
@onready var _status_label: Label = $CanvasLayer/TopBar/TopMargin/TopVBox/StatusLabel
@onready var _control_label: Label = $CanvasLayer/TopBar/TopMargin/TopVBox/ControlLabel
@onready var _prompt_label: Label = $CanvasLayer/PromptBar/PromptMargin/PromptLabel
@onready var _dialogue_box = $CanvasLayer/DialogueBox


func _ready() -> void:
    PrototypeInput.ensure_defaults()
    _content_repository = ChapterContentRepositoryScript.new()
    _content_repository.load_default_content()

    _player.interact_requested.connect(_on_player_interact_requested)
    _player.prompt_changed.connect(_on_player_prompt_changed)
    _dialogue_box.closed.connect(_on_dialogue_closed)

    _control_label.text = "Move: WASD / arrows | Interact: E / Enter | Attack: Space / J | Maps: 1, 2, 3 or Tab"
    _load_map(0)


func _unhandled_input(event: InputEvent) -> void:
    if _dialogue_box.is_open():
        if event.is_action_pressed("interact"):
            _dialogue_box.advance()
            get_viewport().set_input_as_handled()
        return

    if event.is_action_pressed("map_test_room"):
        _load_map(0)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_water_palace"):
        _load_map(1)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_forbidden_falls"):
        _load_map(2)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_next"):
        _load_map(_current_map_index + 1)
        get_viewport().set_input_as_handled()


func _load_map(index: int) -> void:
    var wrapped_index := wrapi(index, 0, MAPS.size())

    if is_instance_valid(_current_map):
        _current_map.queue_free()
        _player.clear_interactables()

    _dialogue_box.hide_immediately()
    _player.set_controls_enabled(true)

    _current_map_index = wrapped_index
    var map_config: Dictionary = MAPS[_current_map_index]
    _current_map = map_config["scene"].instantiate()
    if _current_map.has_method("apply_content_bundle"):
        _current_map.apply_content_bundle(_content_repository.build_bundle(
            map_config.get("scene_ids", []),
            map_config.get("quest_ids", [])
        ))
    _current_map.dialogue_requested.connect(_on_map_dialogue_requested)
    _current_map.status_changed.connect(_on_map_status_changed)
    _map_root.add_child(_current_map)
    _current_map.assign_player(_player)

    _player.global_position = _current_map.get_spawn_position()
    _update_camera_limits(_current_map.get_world_rect())
    _map_label.text = "%s [%d/%d]" % [_current_map.get_map_title(), _current_map_index + 1, MAPS.size()]
    _status_label.text = _current_map.get_status_text()
    _on_player_prompt_changed("")


func _update_camera_limits(world_rect: Rect2) -> void:
    _camera.limit_left = int(world_rect.position.x)
    _camera.limit_top = int(world_rect.position.y)
    _camera.limit_right = int(world_rect.end.x)
    _camera.limit_bottom = int(world_rect.end.y)


func _on_player_interact_requested() -> void:
    if _dialogue_box.is_open():
        _dialogue_box.advance()
        return

    var interactable = _player.get_current_interactable()
    if interactable and interactable.has_method("activate"):
        interactable.activate()


func _on_player_prompt_changed(prompt: String) -> void:
    _prompt_label.text = prompt


func _on_map_dialogue_requested(speaker: String, lines: PackedStringArray) -> void:
    _player.set_controls_enabled(false)
    _dialogue_box.open_dialogue(speaker, lines)
    _prompt_label.text = ""


func _on_dialogue_closed() -> void:
    _player.set_controls_enabled(true)
    _on_player_prompt_changed("")


func _on_map_status_changed(message: String) -> void:
    _status_label.text = message
