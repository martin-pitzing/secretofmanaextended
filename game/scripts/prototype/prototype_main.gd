extends Node2D

const PrototypeInput = preload("res://scripts/prototype/prototype_input.gd")
const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")
const ChapterRuntimeStateScript = preload("res://scripts/data/chapter_runtime_state.gd")
const ChapterStateStoreScript = preload("res://scripts/data/chapter_state_store.gd")

const CAMPAIGN_CHAPTER_IDS := [
    "ch01_falls_to_pandora",
    "ch02_pandora_under_strain"
]

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
    },
    {
        "title": "Pandora District",
        "scene": preload("res://scenes/prototype/maps/pandora_district_benchmark.tscn")
    }
]

const STORY_MAP_INDEX_BY_SCENE := {
    "ch01_sc02_forbidden_falls": 2,
    "ch01_sc05_water_palace_approach": 1,
    "ch01_sc06_luka_charge": 1,
    "ch01_sc08_pandora_gate_district": 3,
    "ch02_sc01_gate_district_morning_after": 3,
    "ch02_sc02_rumors_of_dyluck": 3,
    "ch02_sc03_court_wall_garden_breach": 3,
    "ch02_sc04_terms_of_alliance": 3,
    "ch02_sc05_pandora_court_divides": 3,
    "ch02_sc06_kroll_offer": 3,
    "ch02_sc07_mission_ledger": 3,
    "ch02_sc08_departure_lower_gate": 3
}

var _current_map_index: int = 0
var _current_map
var _content_repository
var _chapter_runtime
var _chapter_state_store
var _current_chapter_index: int = 0
var _manual_map_override: int = -1
var _map_status_text: String = ""
var _pending_scene_completion: Dictionary = {}

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
    _chapter_state_store = ChapterStateStoreScript.new()

    _player.interact_requested.connect(_on_player_interact_requested)
    _player.prompt_changed.connect(_on_player_prompt_changed)
    _dialogue_box.closed.connect(_on_dialogue_closed)

    var resume_lines: PackedStringArray = _restore_saved_campaign_state()
    if resume_lines.is_empty():
        _load_story_scene(true)
    else:
        _load_story_scene(false)
        resume_lines.append_array(_build_scene_intro_lines())
        _open_dialogue("Story Ledger", resume_lines)


func _unhandled_input(event: InputEvent) -> void:
    if _dialogue_box.is_open():
        if event.is_action_pressed("interact"):
            _dialogue_box.advance()
            get_viewport().set_input_as_handled()
        return

    if event.is_action_pressed("chapter_restart"):
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
    elif event.is_action_pressed("map_pandora"):
        _manual_map_override = 3
        _load_story_scene(false)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_next"):
        _cycle_manual_override()
        get_viewport().set_input_as_handled()


func _restart_chapter() -> void:
    _chapter_runtime.restart()
    _clear_saved_chapter_state()
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
    var map_index: int = _resolve_story_map_index(current_scene_id)
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
    _current_map.scene_completion_requested.connect(_on_map_scene_completion_requested)
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
    _control_label.text = "%s\nE interact | Space attack | R restart | C story routing | 1/2/3/4 debug maps" % details


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


func _build_completion_lines(completion_result: Dictionary, next_chapter_title: String = "") -> PackedStringArray:
    var chapter_title := _get_current_chapter_title()
    var lines := PackedStringArray([
        "%s runtime pass is complete." % chapter_title
    ])

    var flags_added: Array = []
    flags_added.append_array(completion_result.get("scene_flags_added", []))
    flags_added.append_array(completion_result.get("quest_flags_added", []))
    if not flags_added.is_empty():
        lines.append("Final flags added: %s" % ", ".join(flags_added))

    if not next_chapter_title.is_empty():
        lines.append("Next chapter unlocked: %s" % next_chapter_title)
    else:
        lines.append("All currently wired prototype chapters are complete.")
    return lines


func _build_scene_completion_feedback_lines(completion_result: Dictionary) -> PackedStringArray:
    var lines := PackedStringArray()
    var completed_scene_id := str(completion_result.get("scene_id", ""))
    var completed_scene: Dictionary = _content_repository.get_scene(completed_scene_id)
    if not completed_scene.is_empty():
        lines.append("Scene complete: %s" % str(completed_scene.get("title", completed_scene_id)))

    var quest_completed_id := str(completion_result.get("quest_completed_id", ""))
    if not quest_completed_id.is_empty():
        var completed_quest: Dictionary = _content_repository.get_quest(quest_completed_id)
        lines.append("Quest complete: %s" % str(completed_quest.get("title", quest_completed_id)))

    var new_flags: Array = []
    new_flags.append_array(completion_result.get("scene_flags_added", []))
    new_flags.append_array(completion_result.get("quest_flags_added", []))
    if not new_flags.is_empty():
        lines.append("Flags updated: %s" % ", ".join(new_flags))

    if not completion_result.get("chapter_complete", false):
        var next_scene: Dictionary = _chapter_runtime.get_current_scene_record()
        if not next_scene.is_empty():
            lines.append("Next scene: %s" % str(next_scene.get("title", "Next scene")))

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


func _on_map_scene_completion_requested(payload: Dictionary) -> void:
    if not _pending_scene_completion.is_empty():
        return

    var summary: Dictionary = _chapter_runtime.get_progress_summary()
    if summary.get("chapter_complete", false):
        _open_dialogue(_get_current_chapter_title(), PackedStringArray([
            "%s is already complete in this runtime pass." % _get_current_chapter_title(),
            "Press R to restart the chapter or continue exploring the current benchmark space."
        ]))
        return

    var completion_result: Dictionary = _chapter_runtime.complete_current_scene()
    _persist_chapter_state()

    var lines := PackedStringArray(payload.get("lines", PackedStringArray()))
    lines.append_array(_build_scene_completion_feedback_lines(completion_result))

    var next_chapter_index := -1
    if completion_result.get("chapter_complete", false):
        next_chapter_index = _get_next_chapter_index()
        lines.append_array(_build_completion_lines(
            completion_result,
            _get_chapter_title(CAMPAIGN_CHAPTER_IDS[next_chapter_index]) if next_chapter_index != -1 else ""
        ))

    _pending_scene_completion = {
        "chapter_complete": bool(completion_result.get("chapter_complete", false)),
        "next_chapter_index": next_chapter_index
    }

    _update_story_header()
    _open_dialogue(str(payload.get("speaker", "Story Ledger")), lines)
    _prompt_label.text = ""


func _open_dialogue(speaker: String, lines: PackedStringArray) -> void:
    _player.set_controls_enabled(false)
    _dialogue_box.open_dialogue(speaker, lines)


func _on_dialogue_closed() -> void:
    var pending_completion := _pending_scene_completion.duplicate()
    _pending_scene_completion.clear()
    _player.set_controls_enabled(true)
    _on_player_prompt_changed("")
    if pending_completion.is_empty():
        return
    if pending_completion.get("chapter_complete", false):
        var next_chapter_index := int(pending_completion.get("next_chapter_index", -1))
        if next_chapter_index != -1:
            _manual_map_override = -1
            _set_active_chapter_by_index(next_chapter_index)
            _load_story_scene(false)
            var transition_lines := PackedStringArray([
                "Campaign handoff complete.",
                "%s begins." % _get_current_chapter_title()
            ])
            transition_lines.append_array(_build_scene_intro_lines())
            _open_dialogue("Story Ledger", transition_lines)
            return
        _update_story_header()
        return
    _load_story_scene(true)


func _on_map_status_changed(message: String) -> void:
    _map_status_text = message
    _update_story_header()


func _persist_chapter_state() -> void:
    _chapter_state_store.save_chapter_state(_chapter_runtime.get_chapter_id(), _chapter_runtime.serialize_state())


func _clear_saved_chapter_state() -> void:
    _chapter_state_store.clear_chapter_state(_chapter_runtime.get_chapter_id())


func _restore_saved_campaign_state() -> PackedStringArray:
    var last_completed_chapter_id: String = ""

    for chapter_index in range(CAMPAIGN_CHAPTER_IDS.size()):
        _set_active_chapter_by_index(chapter_index)
        var chapter_id: String = _chapter_runtime.get_chapter_id()
        var saved_state: Dictionary = _chapter_state_store.load_chapter_state(chapter_id)
        if saved_state.is_empty():
            if not last_completed_chapter_id.is_empty():
                return PackedStringArray([
                    "%s remains complete." % _get_chapter_title(last_completed_chapter_id),
                    "Starting %s." % _get_current_chapter_title()
                ])
            return PackedStringArray()

        if not _chapter_runtime.restore_state(saved_state):
            return PackedStringArray()

        var summary: Dictionary = _chapter_runtime.get_progress_summary()
        if not summary.get("chapter_complete", false):
            return PackedStringArray([
                "Saved %s progress restored." % _get_current_chapter_title(),
                "Resuming at scene %d/%d: %s." % [
                    int(summary.get("scene_number", 0)),
                    int(summary.get("scene_total", 0)),
                    str(_chapter_runtime.get_current_scene_record().get("title", "Current scene"))
                ]
            ])

        last_completed_chapter_id = chapter_id
    return PackedStringArray([
        "All currently wired chapters already have saved completion data.",
        "Reloading the latest chapter for inspection."
    ])


func _set_active_chapter_by_index(chapter_index: int) -> void:
    _current_chapter_index = clampi(chapter_index, 0, CAMPAIGN_CHAPTER_IDS.size() - 1)
    _chapter_runtime.configure(_content_repository, CAMPAIGN_CHAPTER_IDS[_current_chapter_index])


func _get_next_chapter_index() -> int:
    var next_index := _current_chapter_index + 1
    if next_index >= CAMPAIGN_CHAPTER_IDS.size():
        return -1
    return next_index


func _get_current_chapter_title() -> String:
    return _get_chapter_title(_chapter_runtime.get_chapter_id())


func _get_chapter_title(chapter_id: String) -> String:
    var chapter_record: Dictionary = _content_repository.get_chapter(chapter_id)
    return str(chapter_record.get("title", chapter_id))
