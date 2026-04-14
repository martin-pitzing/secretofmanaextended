extends Node2D

class_name PrototypeMap

const DIALOGUE_TRIGGER_SCRIPT = preload("res://scripts/prototype/dialogue_trigger.gd")
const PRACTICE_ENEMY_SCENE = preload("res://scenes/prototype/practice_enemy.tscn")

signal dialogue_requested(speaker: String, lines: PackedStringArray)
signal status_changed(message: String)

var _collision_root: Node2D
var _enemy_root: Node2D
var _trigger_root: Node2D
var _active_enemy_count := 0
var _content_bundle := {
    "scene_ids": [],
    "quest_ids": [],
    "scenes": {},
    "quests": {}
}


func _ready() -> void:
    _collision_root = Node2D.new()
    _collision_root.name = "CollisionRoot"
    add_child(_collision_root)

    _enemy_root = Node2D.new()
    _enemy_root.name = "EnemyRoot"
    add_child(_enemy_root)

    _trigger_root = Node2D.new()
    _trigger_root.name = "TriggerRoot"
    add_child(_trigger_root)

    _build_world_bounds()
    _build_wall_colliders()
    _build_triggers()
    _build_enemies()

    set_process(true)
    status_changed.emit(get_status_text())
    queue_redraw()


func _process(_delta: float) -> void:
    queue_redraw()


func assign_player(player: Node2D) -> void:
    for enemy in _enemy_root.get_children():
        if enemy.has_method("configure"):
            enemy.configure(player)


func apply_content_bundle(content_bundle: Dictionary) -> void:
    _content_bundle = content_bundle


func get_map_id() -> String:
    return "prototype_map"


func get_map_title() -> String:
    return "Prototype Map"


func get_map_subtitle() -> String:
    return "General runtime sandbox"


func get_status_text() -> String:
    return get_map_subtitle()


func get_world_rect() -> Rect2:
    return Rect2(0, 0, 640, 360)


func get_spawn_position() -> Vector2:
    return Vector2(96, 180)


func get_background_color() -> Color:
    return Color(0.0470588, 0.0745098, 0.101961, 1)


func get_wall_color() -> Color:
    return Color(0.129412, 0.176471, 0.203922, 1)


func get_wall_outline_color() -> Color:
    return Color(0.25098, 0.333333, 0.360784, 1)


func get_floor_rects() -> Array:
    return []


func get_overlay_rects() -> Array:
    return []


func get_circle_draws() -> Array:
    return []


func get_line_draws() -> Array:
    return []


func get_wall_rects() -> Array:
    return []


func get_trigger_specs() -> Array:
    return []


func get_enemy_specs() -> Array:
    return []


func get_active_enemy_count() -> int:
    return _active_enemy_count


func get_scene_record(scene_id: String) -> Dictionary:
    return _content_bundle.get("scenes", {}).get(scene_id, {})


func get_quest_record(quest_id: String) -> Dictionary:
    return _content_bundle.get("quests", {}).get(quest_id, {})


func get_primary_scene_record() -> Dictionary:
    var scene_ids: Array = _content_bundle.get("scene_ids", [])
    if scene_ids.is_empty():
        return {}
    return get_scene_record(str(scene_ids[0]))


func get_primary_quest_record() -> Dictionary:
    var quest_ids: Array = _content_bundle.get("quest_ids", [])
    if quest_ids.is_empty():
        return {}
    return get_quest_record(str(quest_ids[0]))


func get_loaded_content_counts() -> Dictionary:
    return {
        "scene_count": int(_content_bundle.get("library_scene_count", _content_bundle.get("scenes", {}).size())),
        "quest_count": int(_content_bundle.get("library_quest_count", _content_bundle.get("quests", {}).size()))
    }


func scene_lines(scene_id: String, max_lines := 3) -> PackedStringArray:
    var scene := get_scene_record(scene_id)
    if scene.is_empty():
        return PackedStringArray()

    var lines := PackedStringArray()
    lines.append("Scene: %s" % scene.get("title", scene_id))

    var player_goal := str(scene.get("player_goal", ""))
    if not player_goal.is_empty():
        lines.append("Goal: %s" % player_goal)

    var narrative_beat := str(scene.get("narrative_beat", ""))
    if not narrative_beat.is_empty() and lines.size() < max_lines:
        lines.append("Beat: %s" % narrative_beat)

    var gameplay_beat := list_to_sentence(scene.get("gameplay_beat", []))
    if not gameplay_beat.is_empty() and lines.size() < max_lines:
        lines.append("Play: %s" % gameplay_beat)

    return _trim_lines(lines, max_lines)


func quest_lines(quest_id: String, max_lines := 3) -> PackedStringArray:
    var quest := get_quest_record(quest_id)
    if quest.is_empty():
        return PackedStringArray()

    var lines := PackedStringArray()
    lines.append("Quest: %s" % quest.get("title", quest_id))

    var objectives := list_to_sentence(quest.get("objectives", []))
    if not objectives.is_empty():
        lines.append("Objectives: %s" % objectives)

    var rewards := list_to_sentence(quest.get("rewards", []))
    if not rewards.is_empty() and lines.size() < max_lines:
        lines.append("Rewards: %s" % rewards)

    return _trim_lines(lines, max_lines)


func list_to_sentence(values) -> String:
    if values is PackedStringArray:
        return ", ".join(values)
    if values is Array:
        var normalized := []
        for value in values:
            normalized.append(str(value))
        return ", ".join(normalized)
    return str(values)


func _trim_lines(lines: PackedStringArray, max_lines: int) -> PackedStringArray:
    if max_lines <= 0 or lines.size() <= max_lines:
        return lines
    return PackedStringArray(lines.slice(0, max_lines))


func _draw() -> void:
    draw_rect(get_world_rect(), get_background_color(), true)
    _draw_rect_entries(get_floor_rects())
    _draw_rect_entries(get_overlay_rects())

    for wall_rect in get_wall_rects():
        draw_rect(wall_rect, get_wall_color(), true)
        draw_rect(wall_rect, get_wall_outline_color(), false, 2.0)

    for circle_draw in get_circle_draws():
        draw_circle(circle_draw.get("position", Vector2.ZERO), circle_draw.get("radius", 8.0), circle_draw.get("color", Color.WHITE))

    for line_draw in get_line_draws():
        draw_line(
            line_draw.get("from", Vector2.ZERO),
            line_draw.get("to", Vector2.ZERO),
            line_draw.get("color", Color.WHITE),
            line_draw.get("width", 2.0)
        )


func _draw_rect_entries(entries: Array) -> void:
    for entry in entries:
        var rect: Rect2 = entry.get("rect", Rect2())
        var color = entry.get("color", Color.WHITE)
        var filled = entry.get("filled", true)
        var width = entry.get("width", 1.0)
        if filled:
            draw_rect(rect, color, true)
        else:
            draw_rect(rect, color, false, width)


func _build_world_bounds() -> void:
    var bounds := get_world_rect()
    var padding := 32.0

    _add_blocker(Rect2(bounds.position.x - padding, bounds.position.y - padding, bounds.size.x + padding * 2.0, padding))
    _add_blocker(Rect2(bounds.position.x - padding, bounds.end.y, bounds.size.x + padding * 2.0, padding))
    _add_blocker(Rect2(bounds.position.x - padding, bounds.position.y, padding, bounds.size.y))
    _add_blocker(Rect2(bounds.end.x, bounds.position.y, padding, bounds.size.y))


func _build_wall_colliders() -> void:
    for wall_rect in get_wall_rects():
        _add_blocker(wall_rect)


func _build_triggers() -> void:
    for trigger_spec in get_trigger_specs():
        var trigger = DIALOGUE_TRIGGER_SCRIPT.new()
        trigger.configure(trigger_spec)
        trigger.dialogue_requested.connect(_on_trigger_dialogue_requested)
        _trigger_root.add_child(trigger)


func _build_enemies() -> void:
    _active_enemy_count = 0
    for enemy_spec in get_enemy_specs():
        var enemy = PRACTICE_ENEMY_SCENE.instantiate()
        enemy.position = enemy_spec.get("position", Vector2.ZERO)
        enemy.base_color = enemy_spec.get("color", enemy.base_color)
        enemy.move_speed = enemy_spec.get("move_speed", enemy.move_speed)
        enemy.aggro_radius = enemy_spec.get("aggro_radius", enemy.aggro_radius)
        enemy.idle_radius = enemy_spec.get("idle_radius", enemy.idle_radius)
        enemy.hit_points = enemy_spec.get("hit_points", enemy.hit_points)
        enemy.defeated.connect(_on_enemy_defeated)
        _enemy_root.add_child(enemy)
        _active_enemy_count += 1


func _add_blocker(rect: Rect2) -> void:
    var blocker := StaticBody2D.new()
    blocker.collision_layer = 1
    blocker.collision_mask = 0
    blocker.position = rect.position + rect.size * 0.5

    var collider := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.size = rect.size
    collider.shape = shape

    blocker.add_child(collider)
    _collision_root.add_child(blocker)


func _on_trigger_dialogue_requested(speaker: String, lines: PackedStringArray) -> void:
    dialogue_requested.emit(speaker, lines)


func _on_enemy_defeated(_enemy) -> void:
    _active_enemy_count = max(_active_enemy_count - 1, 0)
    status_changed.emit(get_status_text())
