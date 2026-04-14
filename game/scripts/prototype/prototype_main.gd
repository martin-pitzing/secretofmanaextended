extends Node2D

const PrototypeInput = preload("res://scripts/prototype/prototype_input.gd")
const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")
const ChapterRuntimeStateScript = preload("res://scripts/data/chapter_runtime_state.gd")

const DEBUG_MAPS := [
    {
        "title": "Test Hall",
        "scene": preload("res://scenes/prototype/maps/test_room.tscn")
    },
    {
        "title": "Water Palace",
        "scene": preload("res://scenes/prototype/maps/water_palace_benchmark.tscn")
    },
    {
        "title": "Forbidden Falls",
        "scene": preload("res://scenes/prototype/maps/forbidden_falls_benchmark.tscn")
    }
]

const STORY_MAP_INDEX_BY_SCENE := {
    "ch01_sc02_forbidden_falls": 2,
    "ch01_sc05_water_palace_approach": 1,
    "ch01_sc06_luka_charge": 1
}

var _current_map_index: int = 0
var _current_map
var _content_repository
var _chapter_runtime
var _manual_map_override: int = -1
var _map_status_text: String = ""

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
    _chapter_runtime = ChapterRuntimeStateScript.new()
    _chapter_runtime.configure(_content_repository, "ch01_falls_to_pandora")

    _player.interact_requested.connect(_on_player_interact_requested)
    _player.prompt_changed.connect(_on_player_prompt_changed)
    _dialogue_box.closed.connect(_on_dialogue_closed)

    _load_story_scene(true)


func _unhandled_input(event: InputEvent) -> void:
    if _dialogue_box.is_open():
        if event.is_action_pressed("interact"):
            _dialogue_box.advance()
            get_viewport().set_input_as_handled()
        return

    if event.is_action_pressed("scene_advance"):
        _advance_story_scene()
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("chapter_restart"):
        _restart_chapter()
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("chapter_story_mode"):
        _manual_map_override = -1
        _load_story_scene(true)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_test_room"):
        _manual_map_override = 0
        _load_story_scene(false)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_water_palace"):
        _manual_map_override = 1
        _load_story_scene(false)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_forbidden_falls"):
        _manual_map_override = 2
        _load_story_scene(false)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_next"):
        _cycle_manual_override()
        get_viewport().set_input_as_handled()


func _advance_story_scene() -> void:
    var summary: Dictionary = _chapter_runtime.get_progress_summary()
    if summary.get("chapter_complete", false):
        _open_dialogue("Chapter 1", PackedStringArray([
            "Chapter 1 is already complete in this prototype pass.",
            "Press R to restart the sequence or continue exploring the current benchmark space."
        ]))
        return

    var completion_result: Dictionary = _chapter_runtime.complete_current_scene()
    if completion_result.get("chapter_complete", false):
        _update_story_header()
        _open_dialogue("Chapter 1 Complete", _build_completion_lines(completion_result))
        return

    _load_story_scene(true, completion_result)


func _restart_chapter() -> void:
    _chapter_runtime.restart()
    _manual_map_override = -1
    _load_story_scene(true)


func _cycle_manual_override() -> void:
    if _manual_map_override == -1:
        _manual_map_override = 0
    else:
        _manual_map_override = wrapi(_manual_map_override + 1, 0, DEBUG_MAPS.size())
    _load_story_scene(false)


func _load_story_scene(show_intro: bool, completion_result: Dictionary = {}) -> void:
    var current_scene_id: String = _chapter_runtime.get_current_scene_id()
    var bundle: Dictionary = _chapter_runtime.build_current_bundle()
    var map_index := _resolve_story_map_index(current_scene_id)
    if _manual_map_override != -1:
        map_index = _manual_map_override

    _load_map_scene(map_index, bundle)
    _update_story_header()

    if show_intro:
        _open_dialogue(_resolve_scene_brief_speaker(), _build_scene_intro_lines(completion_result))


func _load_map_scene(index: int, content_bundle: Dictionary) -> void:
    _current_map_index = wrapi(index, 0, DEBUG_MAPS.size())
    _map_status_text = ""

    if is_instance_valid(_current_map):
        _current_map.queue_free()
        _player.clear_interactables()

    _dialogue_box.hide_immediately()
    _player.set_controls_enabled(true)

    _current_map = DEBUG_MAPS[_current_map_index]["scene"].instantiate()
    if _current_map.has_method("apply_content_bundle"):
        _current_map.apply_content_bundle(content_bundle)
    _current_map.dialogue_requested.connect(_on_map_dialogue_requested)
    _current_map.status_changed.connect(_on_map_status_changed)
    _map_root.add_child(_current_map)
    _current_map.assign_player(_player)

    _player.global_position = _current_map.get_spawn_position()
    _update_camera_limits(_current_map.get_world_rect())
    _on_player_prompt_changed("")


func _resolve_story_map_index(scene_id: String) -> int:
    return int(STORY_MAP_INDEX_BY_SCENE.get(scene_id, 0))


func _update_camera_limits(world_rect: Rect2) -> void:
    _camera.limit_left = int(world_rect.position.x)
    _camera.limit_top = int(world_rect.position.y)
    _camera.limit_right = int(world_rect.end.x)
    _camera.limit_bottom = int(world_rect.end.y)


func _update_story_header() -> void:
    var summary: Dictionary = _chapter_runtime.get_progress_summary()
    var scene: Dictionary = _chapter_runtime.get_current_scene_record()
    var quest: Dictionary = _chapter_runtime.get_active_quest_record()
    var chapter_title := str(summary.get("chapter_title", "Chapter"))
    var scene_title := str(scene.get("title", "No scene loaded"))
    var scene_number := int(summary.get("scene_number", 0))
    var scene_total := int(summary.get("scene_total", 0))

    _map_label.text = "%s | Scene %d/%d: %s" % [chapter_title, scene_number, scene_total, scene_title]

    var quest_state := "Quest state: chapter complete"
    if not quest.is_empty():
        quest_state = "Quest %d/%d active: %s" % [
            int(quest.get("sequence", summary.get("completed_quest_count", 0) + 1)),
            int(summary.get("quest_total", 0)),
            str(quest.get("title", "Active quest"))
        ]

    var map_title := "Map: %s" % _current_map.get_map_title() if is_instance_valid(_current_map) else "Map pending"
    if _manual_map_override != -1:
        map_title += " [manual override]"
    _status_label.text = "%s\n%s | Flags: %d" % [quest_state, map_title, int(summary.get("flag_count", 0))]

    var goal := str(scene.get("player_goal", ""))
    var beat := str(scene.get("narrative_beat", ""))
    var details := goal if not goal.is_empty() else beat
    if not _map_status_text.is_empty():
        details = "%s | %s" % [details, _map_status_text]
    _control_label.text = "%s\nE interact | Space attack | N next scene | R restart | C story routing | 1/2/3 debug maps" % details


func _build_scene_intro_lines(completion_result: Dictionary = {}) -> PackedStringArray:
    var scene: Dictionary = _chapter_runtime.get_current_scene_record()
    var quest: Dictionary = _chapter_runtime.get_active_quest_record()
    var lines := PackedStringArray()

    if not completion_result.is_empty():
        var quest_completed_id := str(completion_result.get("quest_completed_id", ""))
        if not quest_completed_id.is_empty():
            var completed_quest: Dictionary = _content_repository.get_quest(quest_completed_id)
            lines.append("Quest complete: %s" % str(completed_quest.get("title", quest_completed_id)))

        var new_flags: Array = []
        new_flags.append_array(completion_result.get("scene_flags_added", []))
        new_flags.append_array(completion_result.get("quest_flags_added", []))
        if not new_flags.is_empty():
            lines.append("Flags updated: %s" % ", ".join(new_flags))

    if not quest.is_empty():
        lines.append("Quest: %s" % str(quest.get("title", "Current quest")))

    lines.append("Scene: %s" % str(scene.get("title", "Current scene")))

    var goal := str(scene.get("player_goal", ""))
    if not goal.is_empty():
        lines.append("Goal: %s" % goal)

    var beat := str(scene.get("narrative_beat", ""))
    if not beat.is_empty():
        lines.append("Beat: %s" % beat)

    return PackedStringArray(lines.slice(0, 5))


func _build_completion_lines(completion_result: Dictionary) -> PackedStringArray:
    var lines := PackedStringArray([
        "Chapter 1 runtime pass is complete. The sequence reached Pandora and resolved all four main Chapter 1 quests."
    ])

    var flags_added: Array = []
    flags_added.append_array(completion_result.get("scene_flags_added", []))
    flags_added.append_array(completion_result.get("quest_flags_added", []))
    if not flags_added.is_empty():
        lines.append("Final flags added: %s" % ", ".join(flags_added))

    lines.append("Next engineering step: replace manual scene advancement with trigger-based completion and chapter state persistence.")
    return lines


func _resolve_scene_brief_speaker() -> String:
    var scene: Dictionary = _chapter_runtime.get_current_scene_record()
    var participants: Array = scene.get("participants", [])
    if participants is Array:
        for participant in participants:
            var candidate := str(participant)
            if candidate == "Randi":
                continue
            if candidate == "party":
                continue
            if candidate.is_empty():
                continue
            return candidate
    return "Story Ledger"


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
    _open_dialogue(speaker, lines)
    _prompt_label.text = ""


func _open_dialogue(speaker: String, lines: PackedStringArray) -> void:
    _player.set_controls_enabled(false)
    _dialogue_box.open_dialogue(speaker, lines)


func _on_dialogue_closed() -> void:
    _player.set_controls_enabled(true)
    _on_player_prompt_changed("")


func _on_map_status_changed(message: String) -> void:
    _map_status_text = message
    _update_story_header()
