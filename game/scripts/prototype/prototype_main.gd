extends Node2D

const PrototypeInput = preload("res://scripts/prototype/prototype_input.gd")
const ChapterContentRepositoryScript = preload("res://scripts/data/chapter_content_repository.gd")
const ChapterRuntimeStateScript = preload("res://scripts/data/chapter_runtime_state.gd")
const ChapterStateStoreScript = preload("res://scripts/data/chapter_state_store.gd")

const CAMPAIGN_CHAPTER_IDS := [
    "ch01_falls_to_pandora",
    "ch02_pandora_under_strain"
]

const AUTOSAVE_INTERVAL := 1.5
const AUTOSAVE_DISTANCE := 20.0

const DEBUG_MAPS := [
    {
        "title": "Test Hall",
        "map_id": "test_room",
        "scene": preload("res://scenes/prototype/maps/test_room.tscn")
    },
    {
        "title": "Water Palace",
        "map_id": "water_palace",
        "scene": preload("res://scenes/prototype/maps/water_palace_benchmark.tscn")
    },
    {
        "title": "Forbidden Falls",
        "map_id": "forbidden_falls",
        "scene": preload("res://scenes/prototype/maps/forbidden_falls_benchmark.tscn")
    },
    {
        "title": "Pandora Gate District",
        "map_id": "pandora_gate_district",
        "scene": preload("res://scenes/prototype/maps/pandora_district_benchmark.tscn")
    },
    {
        "title": "Pandora Court Route",
        "map_id": "pandora_court_route",
        "scene": preload("res://scenes/prototype/maps/pandora_court_route_benchmark.tscn")
    },
    {
        "title": "Pandora Annex Route",
        "map_id": "pandora_annex_route",
        "scene": preload("res://scenes/prototype/maps/pandora_annex_route_benchmark.tscn")
    },
    {
        "title": "Potos Story Stage",
        "map_id": "potos_story_stage",
        "scene": preload("res://scenes/prototype/maps/potos_story_stage.tscn")
    },
    {
        "title": "Exile Road Stage",
        "map_id": "exile_road_stage",
        "scene": preload("res://scenes/prototype/maps/exile_road_stage.tscn")
    },
    {
        "title": "Water Palace Approach Stage",
        "map_id": "water_palace_approach_stage",
        "scene": preload("res://scenes/prototype/maps/water_palace_approach_stage.tscn")
    },
    {
        "title": "Road To Pandora Stage",
        "map_id": "road_to_pandora_stage",
        "scene": preload("res://scenes/prototype/maps/road_to_pandora_stage.tscn")
    }
]

const STORY_MAP_INDEX_BY_SCENE := {
    "ch01_sc01_potos_morning": 6,
    "ch01_sc02_forbidden_falls": 2,
    "ch01_sc03_judgment_at_potos": 6,
    "ch01_sc04_exile_procession": 7,
    "ch01_sc05_water_palace_approach": 8,
    "ch01_sc06_luka_charge": 1,
    "ch01_sc07_road_to_pandora": 9,
    "ch01_sc08_pandora_gate_district": 3,
    "ch02_sc01_gate_district_morning_after": 3,
    "ch02_sc02_rumors_of_dyluck": 3,
    "ch02_sc03_court_wall_garden_breach": 4,
    "ch02_sc04_terms_of_alliance": 4,
    "ch02_sc05_pandora_court_divides": 4,
    "ch02_sc06_kroll_offer": 5,
    "ch02_sc07_mission_ledger": 5,
    "ch02_sc08_departure_lower_gate": 5
}

var _current_map_index := 0
var _current_map
var _content_repository
var _chapter_runtime
var _chapter_state_store
var _current_chapter_index := 0
var _manual_map_override := -1
var _map_status_text := ""
var _pending_scene_completion := {}
var _pending_chapter_transition := {}
var _resume_option := {}
var _session_started := false
var _autosave_elapsed := 0.0
var _last_saved_map_id := ""
var _last_saved_player_position := Vector2.ZERO
var _has_saved_player_position := false

@onready var _map_root: Node2D = $MapRoot
@onready var _player = $Player
@onready var _camera: Camera2D = $Player/Camera2D
@onready var _top_bar: PanelContainer = $CanvasLayer/TopBar
@onready var _prompt_bar: PanelContainer = $CanvasLayer/PromptBar
@onready var _map_label: Label = $CanvasLayer/TopBar/TopMargin/TopVBox/MapLabel
@onready var _status_label: Label = $CanvasLayer/TopBar/TopMargin/TopVBox/StatusLabel
@onready var _control_label: Label = $CanvasLayer/TopBar/TopMargin/TopVBox/ControlLabel
@onready var _prompt_label: Label = $CanvasLayer/PromptBar/PromptMargin/PromptLabel
@onready var _dialogue_box = $CanvasLayer/DialogueBox
@onready var _campaign_backdrop: ColorRect = $CanvasLayer/CampaignBackdrop
@onready var _campaign_menu: PanelContainer = $CanvasLayer/CampaignMenu
@onready var _campaign_summary_label: Label = $CanvasLayer/CampaignMenu/MenuMargin/MenuVBox/MenuSummary
@onready var _continue_button: Button = $CanvasLayer/CampaignMenu/MenuMargin/MenuVBox/ContinueButton
@onready var _restart_chapter_button: Button = $CanvasLayer/CampaignMenu/MenuMargin/MenuVBox/RestartChapterButton
@onready var _restart_campaign_button: Button = $CanvasLayer/CampaignMenu/MenuMargin/MenuVBox/RestartCampaignButton
@onready var _transition_backdrop: ColorRect = $CanvasLayer/TransitionBackdrop
@onready var _transition_card: PanelContainer = $CanvasLayer/TransitionCard
@onready var _transition_title_label: Label = $CanvasLayer/TransitionCard/CardMargin/CardVBox/TransitionTitle
@onready var _transition_chapter_label: Label = $CanvasLayer/TransitionCard/CardMargin/CardVBox/TransitionChapter
@onready var _transition_summary_label: Label = $CanvasLayer/TransitionCard/CardMargin/CardVBox/TransitionSummary
@onready var _transition_continue_button: Button = $CanvasLayer/TransitionCard/CardMargin/CardVBox/TransitionContinueButton


func _ready() -> void:
    PrototypeInput.ensure_defaults()
    _content_repository = ChapterContentRepositoryScript.new()
    _content_repository.load_default_content()
    _chapter_runtime = ChapterRuntimeStateScript.new()
    _chapter_state_store = ChapterStateStoreScript.new()

    _player.interact_requested.connect(_on_player_interact_requested)
    _player.prompt_changed.connect(_on_player_prompt_changed)
    _dialogue_box.closed.connect(_on_dialogue_closed)
    _continue_button.pressed.connect(_on_continue_button_pressed)
    _restart_chapter_button.pressed.connect(_on_restart_chapter_button_pressed)
    _restart_campaign_button.pressed.connect(_on_restart_campaign_button_pressed)
    _transition_continue_button.pressed.connect(_on_transition_continue_button_pressed)

    _set_hud_visible(false)
    _player.visible = false
    _player.set_controls_enabled(false)
    _dialogue_box.hide_immediately()
    _prompt_label.text = ""

    _resume_option = _build_resume_option()
    _show_campaign_menu()


func _process(delta: float) -> void:
    if not _session_started:
        return
    if _manual_map_override != -1:
        return
    if _dialogue_box.is_open():
        return
    if _campaign_menu.visible or _transition_card.visible:
        return
    if not is_instance_valid(_current_map):
        return

    _autosave_elapsed += delta
    if _autosave_elapsed < AUTOSAVE_INTERVAL:
        return
    _autosave_elapsed = 0.0

    var current_position = _player.global_position
    var story_map_id = _get_story_map_id_for_scene(_chapter_runtime.get_current_scene_id())
    var map_changed = story_map_id != _last_saved_map_id
    var moved_enough = (not _has_saved_player_position) or current_position.distance_to(_last_saved_player_position) >= AUTOSAVE_DISTANCE
    if map_changed or moved_enough:
        _persist_runtime_progress(true)


func _unhandled_input(event: InputEvent) -> void:
    if _campaign_menu.visible:
        return

    if _transition_card.visible:
        if event.is_action_pressed("interact"):
            _on_transition_continue_button_pressed()
            get_viewport().set_input_as_handled()
        return

    if _dialogue_box.is_open():
        if event.is_action_pressed("interact"):
            _dialogue_box.advance()
            get_viewport().set_input_as_handled()
        return

    if event.is_action_pressed("chapter_restart"):
        _restart_active_chapter()
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("chapter_story_mode"):
        _manual_map_override = -1
        _load_story_scene(true)
        _persist_runtime_progress(true)
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
    elif event.is_action_pressed("map_pandora_court"):
        _manual_map_override = 4
        _load_story_scene(false)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_pandora_annex"):
        _manual_map_override = 5
        _load_story_scene(false)
        get_viewport().set_input_as_handled()
    elif event.is_action_pressed("map_next"):
        _cycle_manual_override()
        get_viewport().set_input_as_handled()


func _show_campaign_menu() -> void:
    var has_save = bool(_resume_option.get("has_save", false))
    var summary_lines = _coerce_text_lines(_resume_option.get("summary_lines", []))

    _campaign_backdrop.visible = true
    _campaign_menu.visible = true
    _transition_backdrop.visible = false
    _transition_card.visible = false
    _dialogue_box.hide_immediately()
    _set_hud_visible(false)
    _player.visible = false
    _player.set_controls_enabled(false)

    if has_save:
        _campaign_summary_label.text = "\n".join(summary_lines)
        _continue_button.text = "Continue"
        _restart_chapter_button.visible = true
        _restart_campaign_button.visible = true
    else:
        _campaign_summary_label.text = "No saved prototype campaign state found.\nStart a new run from Potos and the Forbidden Falls."
        _continue_button.text = "Start New Campaign"
        _restart_chapter_button.visible = false
        _restart_campaign_button.visible = false

    call_deferred("_focus_control", _continue_button)


func _hide_campaign_menu() -> void:
    _campaign_backdrop.visible = false
    _campaign_menu.visible = false
    _player.visible = true
    _set_hud_visible(true)


func _show_transition_card() -> void:
    var next_chapter_id = _chapter_runtime.get_chapter_id()
    var next_chapter_record = _content_repository.get_chapter(next_chapter_id)
    var next_scene = _chapter_runtime.get_current_scene_record()
    var chapter_number = _current_chapter_index + 1
    var summary_lines = PackedStringArray()

    var boundary = str(next_chapter_record.get("boundary", ""))
    if not boundary.is_empty():
        summary_lines.append(boundary)

    var next_goal = str(next_scene.get("player_goal", ""))
    if not next_goal.is_empty():
        summary_lines.append("Opening goal: %s" % next_goal)

    _transition_title_label.text = "Chapter %d" % chapter_number
    _transition_chapter_label.text = str(next_chapter_record.get("title", next_chapter_id))
    _transition_summary_label.text = "\n\n".join(summary_lines)
    _transition_continue_button.text = "Enter %s" % _transition_chapter_label.text

    _transition_backdrop.visible = true
    _transition_card.visible = true
    _dialogue_box.hide_immediately()
    _set_hud_visible(false)
    _player.set_controls_enabled(false)
    call_deferred("_focus_control", _transition_continue_button)


func _hide_transition_card() -> void:
    _transition_backdrop.visible = false
    _transition_card.visible = false
    _set_hud_visible(_session_started)


func _on_continue_button_pressed() -> void:
    if not bool(_resume_option.get("has_save", false)):
        _start_new_campaign()
        return
    _continue_saved_campaign()


func _on_restart_chapter_button_pressed() -> void:
    _restart_saved_chapter()


func _on_restart_campaign_button_pressed() -> void:
    _restart_campaign()


func _on_transition_continue_button_pressed() -> void:
    if _pending_chapter_transition.is_empty():
        return

    _pending_chapter_transition.clear()
    _hide_transition_card()
    _manual_map_override = -1
    _load_story_scene(false)
    _persist_runtime_progress(true)

    var intro_lines = PackedStringArray([
        "%s begins." % _get_current_chapter_title()
    ])
    intro_lines.append_array(_build_scene_intro_lines())
    _open_dialogue("Story Ledger", intro_lines)


func _start_new_campaign() -> void:
    _chapter_state_store.clear_all_runtime_state(CAMPAIGN_CHAPTER_IDS)
    _manual_map_override = -1
    _pending_scene_completion.clear()
    _pending_chapter_transition.clear()
    _set_active_chapter_by_index(0)
    _chapter_runtime.restart()
    _begin_runtime_session()
    _load_story_scene(true)
    _persist_runtime_progress(true)


func _continue_saved_campaign() -> void:
    var chapter_index = int(_resume_option.get("chapter_index", 0))
    var chapter_id = str(_resume_option.get("chapter_id", CAMPAIGN_CHAPTER_IDS[chapter_index]))
    var restore_context: Dictionary = _resume_option.get("restore_context", {})
    var transition_pending = bool(_resume_option.get("transition_pending", false))
    var chapter_state = _chapter_state_store.load_chapter_state(chapter_id)

    _manual_map_override = -1
    _pending_scene_completion.clear()
    _pending_chapter_transition.clear()
    _set_active_chapter_by_index(chapter_index)

    if chapter_state.is_empty() or not _chapter_runtime.restore_state(chapter_state):
        _chapter_runtime.restart()
        restore_context = {}
        transition_pending = false

    _begin_runtime_session()
    _load_story_scene(false, {}, restore_context)
    if transition_pending:
        _pending_chapter_transition = {
            "next_chapter_index": _current_chapter_index
        }
        _show_transition_card()
        return
    _persist_runtime_progress(true)


func _restart_saved_chapter() -> void:
    var chapter_index = int(_resume_option.get("chapter_index", 0))
    var chapter_id = str(_resume_option.get("chapter_id", CAMPAIGN_CHAPTER_IDS[chapter_index]))

    _chapter_state_store.clear_campaign_state()
    _chapter_state_store.clear_chapter_state(chapter_id)
    _manual_map_override = -1
    _pending_scene_completion.clear()
    _pending_chapter_transition.clear()
    _set_active_chapter_by_index(chapter_index)
    _chapter_runtime.restart()
    _begin_runtime_session()
    _load_story_scene(true)
    _persist_runtime_progress(true)


func _restart_campaign() -> void:
    _chapter_state_store.clear_all_runtime_state(CAMPAIGN_CHAPTER_IDS)
    _manual_map_override = -1
    _pending_scene_completion.clear()
    _pending_chapter_transition.clear()
    _set_active_chapter_by_index(0)
    _chapter_runtime.restart()
    _begin_runtime_session()
    _load_story_scene(true)
    _persist_runtime_progress(true)


func _begin_runtime_session() -> void:
    _session_started = true
    _hide_campaign_menu()
    _hide_transition_card()
    _player.visible = true
    _player.set_controls_enabled(true)
    _autosave_elapsed = 0.0


func _restart_active_chapter() -> void:
    if not _chapter_runtime.is_valid():
        return

    _chapter_state_store.clear_campaign_state()
    _chapter_state_store.clear_chapter_state(_chapter_runtime.get_chapter_id())
    _manual_map_override = -1
    _pending_scene_completion.clear()
    _pending_chapter_transition.clear()
    _hide_transition_card()
    _chapter_runtime.restart()
    _load_story_scene(true)
    _persist_runtime_progress(true)


func _cycle_manual_override() -> void:
    if _manual_map_override == -1:
        _manual_map_override = 0
    else:
        _manual_map_override = wrapi(_manual_map_override + 1, 0, DEBUG_MAPS.size())
    _load_story_scene(false)


func _load_story_scene(show_intro: bool, completion_result: Dictionary = {}, restore_context: Dictionary = {}) -> void:
    var current_scene_id = _chapter_runtime.get_current_scene_id()
    var bundle = _chapter_runtime.build_current_bundle()
    var map_index = _resolve_story_map_index(current_scene_id)
    if _manual_map_override != -1:
        map_index = _manual_map_override

    _load_map_scene(map_index, bundle, restore_context)
    _update_story_header()

    if show_intro:
        _open_dialogue(_resolve_scene_brief_speaker(), _build_scene_intro_lines(completion_result))


func _load_map_scene(index: int, content_bundle: Dictionary, restore_context: Dictionary = {}) -> void:
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

    _player.global_position = _resolve_player_spawn(restore_context)
    _update_camera_limits(_current_map.get_world_rect())
    _on_player_prompt_changed("")


func _resolve_player_spawn(restore_context: Dictionary) -> Vector2:
    var fallback_spawn = _current_map.get_spawn_position()
    if _manual_map_override != -1:
        return fallback_spawn
    if restore_context.is_empty():
        return fallback_spawn

    var restore_scene_id = str(restore_context.get("current_scene_id", ""))
    var restore_map_id = str(restore_context.get("current_map_id", ""))
    if restore_scene_id != _chapter_runtime.get_current_scene_id():
        return fallback_spawn
    if restore_map_id != _current_map.get_map_id():
        return fallback_spawn

    var raw_position: Dictionary = restore_context.get("player_position", {})
    if raw_position.is_empty():
        return fallback_spawn

    return Vector2(float(raw_position.get("x", fallback_spawn.x)), float(raw_position.get("y", fallback_spawn.y)))


func _resolve_story_map_index(scene_id: String) -> int:
    return int(STORY_MAP_INDEX_BY_SCENE.get(scene_id, 0))


func _get_story_map_id_for_scene(scene_id: String) -> String:
    var map_index = _resolve_story_map_index(scene_id)
    return str(DEBUG_MAPS[map_index].get("map_id", ""))


func _get_map_title_by_id(map_id: String) -> String:
    for map_record in DEBUG_MAPS:
        if str(map_record.get("map_id", "")) == map_id:
            return str(map_record.get("title", map_id))
    return ""


func _update_camera_limits(world_rect: Rect2) -> void:
    _camera.limit_left = int(world_rect.position.x)
    _camera.limit_top = int(world_rect.position.y)
    _camera.limit_right = int(world_rect.end.x)
    _camera.limit_bottom = int(world_rect.end.y)


func _update_story_header() -> void:
    var summary = _chapter_runtime.get_progress_summary()
    var scene = _chapter_runtime.get_current_scene_record()
    var quest = _chapter_runtime.get_active_quest_record()
    var chapter_title = str(summary.get("chapter_title", "Chapter"))
    var scene_title = str(scene.get("title", "No scene loaded"))
    var scene_number = int(summary.get("scene_number", 0))
    var scene_total = int(summary.get("scene_total", 0))

    _map_label.text = "%s | Scene %d/%d: %s" % [chapter_title, scene_number, scene_total, scene_title]

    var quest_state = "Quest state: chapter complete"
    if not quest.is_empty():
        quest_state = "Quest %d/%d active: %s" % [
            int(quest.get("sequence", summary.get("completed_quest_count", 0) + 1)),
            int(summary.get("quest_total", 0)),
            str(quest.get("title", "Active quest"))
        ]

    var map_title = "Map pending"
    if is_instance_valid(_current_map):
        map_title = "Map: %s" % _current_map.get_map_title()
    if _manual_map_override != -1:
        map_title += " [manual override]"
    _status_label.text = "%s\n%s | Flags: %d" % [quest_state, map_title, int(summary.get("flag_count", 0))]

    var goal = str(scene.get("player_goal", ""))
    var beat = str(scene.get("narrative_beat", ""))
    var details = goal if not goal.is_empty() else beat
    if not _map_status_text.is_empty():
        details = "%s | %s" % [details, _map_status_text]
    _control_label.text = "%s\nE interact | Space attack | R restart | C story routing | 1-6 shortcuts | Tab cycles all staged maps" % details


func _build_scene_intro_lines(completion_result: Dictionary = {}) -> PackedStringArray:
    var scene = _chapter_runtime.get_current_scene_record()
    var quest = _chapter_runtime.get_active_quest_record()
    var lines = PackedStringArray()

    if not completion_result.is_empty():
        var quest_completed_id = str(completion_result.get("quest_completed_id", ""))
        if not quest_completed_id.is_empty():
            var completed_quest = _content_repository.get_quest(quest_completed_id)
            lines.append("Quest complete: %s" % str(completed_quest.get("title", quest_completed_id)))

        var new_flags: Array = []
        new_flags.append_array(completion_result.get("scene_flags_added", []))
        new_flags.append_array(completion_result.get("quest_flags_added", []))
        if not new_flags.is_empty():
            lines.append("Flags updated: %s" % ", ".join(new_flags))

    if not quest.is_empty():
        lines.append("Quest: %s" % str(quest.get("title", "Current quest")))

    lines.append("Scene: %s" % str(scene.get("title", "Current scene")))

    var goal = str(scene.get("player_goal", ""))
    if not goal.is_empty():
        lines.append("Goal: %s" % goal)

    var beat = str(scene.get("narrative_beat", ""))
    if not beat.is_empty():
        lines.append("Beat: %s" % beat)

    return PackedStringArray(lines.slice(0, 5))


func _build_completion_lines(completion_result: Dictionary, next_chapter_title: String = "") -> PackedStringArray:
    var chapter_title = _get_current_chapter_title()
    var lines = PackedStringArray([
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
    var lines = PackedStringArray()
    var completed_scene_id = str(completion_result.get("scene_id", ""))
    var completed_scene = _content_repository.get_scene(completed_scene_id)
    if not completed_scene.is_empty():
        lines.append("Scene complete: %s" % str(completed_scene.get("title", completed_scene_id)))

    var quest_completed_id = str(completion_result.get("quest_completed_id", ""))
    if not quest_completed_id.is_empty():
        var completed_quest = _content_repository.get_quest(quest_completed_id)
        lines.append("Quest complete: %s" % str(completed_quest.get("title", quest_completed_id)))

    var new_flags: Array = []
    new_flags.append_array(completion_result.get("scene_flags_added", []))
    new_flags.append_array(completion_result.get("quest_flags_added", []))
    if not new_flags.is_empty():
        lines.append("Flags updated: %s" % ", ".join(new_flags))

    if not completion_result.get("chapter_complete", false):
        var next_scene = _chapter_runtime.get_current_scene_record()
        if not next_scene.is_empty():
            lines.append("Next scene: %s" % str(next_scene.get("title", "Next scene")))

    return lines


func _resolve_scene_brief_speaker() -> String:
    var scene = _chapter_runtime.get_current_scene_record()
    var participants: Array = scene.get("participants", [])
    if participants is Array:
        for participant in participants:
            var candidate = str(participant)
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

    if _campaign_menu.visible or _transition_card.visible:
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

    var summary = _chapter_runtime.get_progress_summary()
    if summary.get("chapter_complete", false):
        _open_dialogue(_get_current_chapter_title(), PackedStringArray([
            "%s is already complete in this runtime pass." % _get_current_chapter_title(),
            "Press R to restart the chapter or continue exploring the current benchmark space."
        ]))
        return

    var completion_result = _chapter_runtime.complete_current_scene()
    _persist_runtime_progress(false)

    var lines = _coerce_text_lines(payload.get("lines", []))
    lines.append_array(_build_scene_completion_feedback_lines(completion_result))

    var next_chapter_index = -1
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
    var pending_completion = _pending_scene_completion.duplicate()
    _pending_scene_completion.clear()
    _player.set_controls_enabled(true)
    _on_player_prompt_changed("")

    if pending_completion.is_empty():
        return

    if pending_completion.get("chapter_complete", false):
        var next_chapter_index = int(pending_completion.get("next_chapter_index", -1))
        if next_chapter_index != -1:
            _prepare_next_chapter_transition(next_chapter_index)
            return
        _update_story_header()
        return

    _load_story_scene(true)
    _persist_runtime_progress(true)


func _prepare_next_chapter_transition(next_chapter_index: int) -> void:
    _manual_map_override = -1
    _set_active_chapter_by_index(next_chapter_index)
    _persist_runtime_progress(false, true)
    _pending_chapter_transition = {
        "next_chapter_index": next_chapter_index
    }
    _show_transition_card()


func _on_map_status_changed(message: String) -> void:
    _map_status_text = message
    _update_story_header()


func _persist_runtime_progress(include_player_context: bool, transition_pending: bool = false) -> void:
    if not _chapter_runtime.is_valid():
        return

    _chapter_state_store.save_chapter_state(_chapter_runtime.get_chapter_id(), _chapter_runtime.serialize_state())
    var snapshot = _build_campaign_state_snapshot(include_player_context, transition_pending)
    _chapter_state_store.save_campaign_state(snapshot)

    _last_saved_map_id = str(snapshot.get("current_map_id", ""))
    var raw_position: Dictionary = snapshot.get("player_position", {})
    if raw_position.is_empty():
        _has_saved_player_position = false
        _last_saved_player_position = Vector2.ZERO
    else:
        _has_saved_player_position = true
        _last_saved_player_position = Vector2(float(raw_position.get("x", 0.0)), float(raw_position.get("y", 0.0)))
    _autosave_elapsed = 0.0


func _build_campaign_state_snapshot(include_player_context: bool, transition_pending: bool = false) -> Dictionary:
    var summary = _chapter_runtime.get_progress_summary()
    var current_scene_id = str(summary.get("scene_id", _chapter_runtime.get_current_scene_id()))
    var story_map_id = _get_story_map_id_for_scene(current_scene_id)
    var scene = _chapter_runtime.get_current_scene_record()
    var snapshot = {
        "current_chapter_id": _chapter_runtime.get_chapter_id(),
        "chapter_title": str(summary.get("chapter_title", _chapter_runtime.get_chapter_id())),
        "current_scene_id": current_scene_id,
        "scene_title": str(scene.get("title", current_scene_id)),
        "current_scene_number": int(summary.get("scene_number", 0)),
        "current_map_id": story_map_id,
        "player_position": {},
        "transition_pending": transition_pending
    }

    if include_player_context and _manual_map_override == -1 and is_instance_valid(_current_map):
        if _current_map.get_map_id() == story_map_id:
            snapshot["player_position"] = {
                "x": _player.global_position.x,
                "y": _player.global_position.y
            }

    return snapshot


func _build_resume_option() -> Dictionary:
    var campaign_state = _chapter_state_store.load_campaign_state()
    if not campaign_state.is_empty():
        var campaign_option = _build_resume_option_from_campaign_state(campaign_state)
        if bool(campaign_option.get("has_save", false)):
            return campaign_option
    return _build_legacy_resume_option()


func _build_resume_option_from_campaign_state(campaign_state: Dictionary) -> Dictionary:
    var chapter_id = str(campaign_state.get("current_chapter_id", ""))
    var chapter_index = CAMPAIGN_CHAPTER_IDS.find(chapter_id)
    if chapter_index == -1:
        return {"has_save": false}

    _set_active_chapter_by_index(chapter_index)
    var chapter_state = _chapter_state_store.load_chapter_state(chapter_id)
    if chapter_state.is_empty() or not _chapter_runtime.restore_state(chapter_state):
        _chapter_runtime.restart()

    var prefix = PackedStringArray([
        "Saved campaign checkpoint detected."
    ])
    return _build_resume_option_from_runtime(chapter_index, campaign_state, prefix)


func _build_legacy_resume_option() -> Dictionary:
    var last_completed_chapter_id = ""

    for chapter_index in range(CAMPAIGN_CHAPTER_IDS.size()):
        _set_active_chapter_by_index(chapter_index)
        var chapter_id = _chapter_runtime.get_chapter_id()
        var saved_state = _chapter_state_store.load_chapter_state(chapter_id)

        if saved_state.is_empty():
            if not last_completed_chapter_id.is_empty():
                _chapter_runtime.restart()
                return _build_resume_option_from_runtime(
                    chapter_index,
                    {},
                    PackedStringArray([
                        "%s remains complete." % _get_chapter_title(last_completed_chapter_id),
                        "Continue will begin %s from its opening scene." % _get_current_chapter_title()
                    ])
                )
            return {"has_save": false}

        if not _chapter_runtime.restore_state(saved_state):
            return {"has_save": false}

        var summary = _chapter_runtime.get_progress_summary()
        if not bool(summary.get("chapter_complete", false)):
            return _build_resume_option_from_runtime(
                chapter_index,
                {},
                PackedStringArray([
                    "Saved chapter progress detected."
                ])
            )

        last_completed_chapter_id = chapter_id

    if CAMPAIGN_CHAPTER_IDS.is_empty():
        return {"has_save": false}

    var final_index = CAMPAIGN_CHAPTER_IDS.size() - 1
    _set_active_chapter_by_index(final_index)
    var final_state = _chapter_state_store.load_chapter_state(CAMPAIGN_CHAPTER_IDS[final_index])
    if not final_state.is_empty():
        _chapter_runtime.restore_state(final_state)

    return _build_resume_option_from_runtime(
        final_index,
        {},
        PackedStringArray([
            "All currently wired chapters are marked complete.",
            "Continue will reopen the latest chapter for inspection."
        ])
    )


func _build_resume_option_from_runtime(chapter_index: int, campaign_state: Dictionary, prefix_lines: PackedStringArray = PackedStringArray()) -> Dictionary:
    var summary = _chapter_runtime.get_progress_summary()
    var scene = _chapter_runtime.get_current_scene_record()
    var chapter_title = str(summary.get("chapter_title", CAMPAIGN_CHAPTER_IDS[chapter_index]))
    var scene_title = str(scene.get("title", campaign_state.get("scene_title", "Current scene")))
    var scene_number = int(summary.get("scene_number", max(int(campaign_state.get("current_scene_number", 1)), 1)))
    var scene_total = int(summary.get("scene_total", _chapter_runtime.get_total_scene_count()))
    var map_id = str(campaign_state.get("current_map_id", _get_story_map_id_for_scene(str(summary.get("scene_id", "")))))
    var map_title = _get_map_title_by_id(map_id)
    var transition_pending = bool(campaign_state.get("transition_pending", false))
    var summary_lines = PackedStringArray()
    summary_lines.append_array(prefix_lines)
    summary_lines.append("Checkpoint: %s" % chapter_title)
    summary_lines.append("Scene %d/%d: %s" % [scene_number, scene_total, scene_title])
    if not map_title.is_empty():
        summary_lines.append("Story route: %s" % map_title)

    var player_position: Dictionary = campaign_state.get("player_position", {})
    if bool(summary.get("chapter_complete", false)):
        summary_lines.append("The current prototype save marks this chapter as complete.")
    elif transition_pending:
        summary_lines.append("Continue reopens the chapter handoff card before play resumes.")
    elif not player_position.is_empty():
        summary_lines.append("Continue restores the in-map checkpoint for the active story route.")
    else:
        summary_lines.append("Continue restores the active chapter and scene state.")

    return {
        "has_save": true,
        "chapter_index": chapter_index,
        "chapter_id": _chapter_runtime.get_chapter_id(),
        "summary_lines": summary_lines,
        "transition_pending": transition_pending,
        "restore_context": {
            "current_scene_id": str(campaign_state.get("current_scene_id", _chapter_runtime.get_current_scene_id())),
            "current_map_id": map_id,
            "player_position": player_position
        }
    }


func _set_active_chapter_by_index(chapter_index: int) -> void:
    _current_chapter_index = clampi(chapter_index, 0, CAMPAIGN_CHAPTER_IDS.size() - 1)
    _chapter_runtime.configure(_content_repository, CAMPAIGN_CHAPTER_IDS[_current_chapter_index])


func _get_next_chapter_index() -> int:
    var next_index = _current_chapter_index + 1
    if next_index >= CAMPAIGN_CHAPTER_IDS.size():
        return -1
    return next_index


func _get_current_chapter_title() -> String:
    return _get_chapter_title(_chapter_runtime.get_chapter_id())


func _get_chapter_title(chapter_id: String) -> String:
    var chapter_record = _content_repository.get_chapter(chapter_id)
    return str(chapter_record.get("title", chapter_id))


func _set_hud_visible(visible: bool) -> void:
    _top_bar.visible = visible
    _prompt_bar.visible = visible


func _focus_control(control: Control) -> void:
    if not is_instance_valid(control):
        return
    if not control.visible:
        return
    control.grab_focus()


func _coerce_text_lines(raw_lines) -> PackedStringArray:
    var output = PackedStringArray()
    for value in raw_lines:
        output.append(str(value))
    return output
