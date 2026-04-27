extends RefCounted

class_name PrototypeChapterRegistry

const Chapter01ModuleScript = preload("res://scripts/prototype/modules/ch01_falls_to_pandora_module.gd")
const Chapter02ModuleScript = preload("res://scripts/prototype/modules/ch02_pandora_under_strain_module.gd")
const ORDERED_CHAPTER_IDS := [
    "ch01_falls_to_pandora",
    "ch02_pandora_under_strain"
]


static func get_available_chapter_ids() -> Array:
    return ORDERED_CHAPTER_IDS.duplicate()


static func has_module(chapter_id: String) -> bool:
    return ORDERED_CHAPTER_IDS.has(chapter_id)


static func get_module(chapter_id: String):
    match chapter_id:
        "ch01_falls_to_pandora":
            return Chapter01ModuleScript.new()
        "ch02_pandora_under_strain":
            return Chapter02ModuleScript.new()
        _:
            return null
