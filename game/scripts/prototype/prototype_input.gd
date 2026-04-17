extends RefCounted


static func ensure_defaults() -> void:
    _ensure_action("move_left", [KEY_A, KEY_LEFT])
    _ensure_action("move_right", [KEY_D, KEY_RIGHT])
    _ensure_action("move_up", [KEY_W, KEY_UP])
    _ensure_action("move_down", [KEY_S, KEY_DOWN])
    _ensure_action("interact", [KEY_E, KEY_ENTER])
    _ensure_action("attack", [KEY_SPACE, KEY_J])
    _ensure_action("map_next", [KEY_TAB])
    _ensure_action("map_test_room", [KEY_1])
    _ensure_action("map_water_palace", [KEY_2])
    _ensure_action("map_forbidden_falls", [KEY_3])
    _ensure_action("map_pandora", [KEY_4])
    _ensure_action("chapter_restart", [KEY_R])
    _ensure_action("chapter_story_mode", [KEY_C])


static func _ensure_action(action_name: String, keycodes: Array) -> void:
    if not InputMap.has_action(action_name):
        InputMap.add_action(action_name)

    var existing_codes := []
    for event in InputMap.action_get_events(action_name):
        if event is InputEventKey:
            if event.physical_keycode != 0:
                existing_codes.append(event.physical_keycode)
            else:
                existing_codes.append(event.keycode)

    for keycode in keycodes:
        if existing_codes.has(keycode):
            continue
        var event := InputEventKey.new()
        event.keycode = keycode
        event.physical_keycode = keycode
        InputMap.action_add_event(action_name, event)
