extends RefCounted

class_name EditorialYamlLoader


static func load_file(path: String) -> Dictionary:
    var file := FileAccess.open(path, FileAccess.READ)
    if file == null:
        push_warning("Could not open editorial YAML file: %s" % path)
        return {}

    var data := {}
    var current_list_key := ""

    while not file.eof_reached():
        var raw_line := file.get_line()
        if raw_line == null:
            continue

        var line := raw_line.rstrip("\r\n")
        if line.strip_edges().is_empty():
            continue
        if line.strip_edges().begins_with("#"):
            continue

        if line.begins_with("  - ") and current_list_key != "":
            if not data.has(current_list_key):
                data[current_list_key] = []
            data[current_list_key].append(_parse_scalar(line.trim_prefix("  - ").strip_edges()))
            continue

        current_list_key = ""

        var separator_index := line.find(":")
        if separator_index == -1:
            continue

        var key := line.substr(0, separator_index).strip_edges()
        var value := line.substr(separator_index + 1).strip_edges()

        if value == "":
            data[key] = []
            current_list_key = key
        else:
            data[key] = _parse_scalar(value)

    return data


static func _parse_scalar(value):
    var trimmed := str(value).strip_edges()
    if trimmed.length() >= 2:
        var first := trimmed[0]
        var last := trimmed[trimmed.length() - 1]
        if (first == "\"" and last == "\"") or (first == "'" and last == "'"):
            trimmed = trimmed.substr(1, trimmed.length() - 2)

    if trimmed.is_valid_int():
        return int(trimmed)
    if trimmed.to_lower() == "true":
        return true
    if trimmed.to_lower() == "false":
        return false
    return trimmed
