extends RefCounted

class_name Chapter1StageBackdrops

const ROOT_PATH := "res://art/ch01/review_stills"
const CANDIDATE_FILENAMES = [
    "backdrop.png",
    "backdrop.webp",
    "backdrop.jpg",
    "backdrop.jpeg",
    "backdrop_v02.png",
    "backdrop_v02.webp",
    "backdrop_v02.jpg",
    "backdrop_v02.jpeg",
    "backdrop_v01.png",
    "backdrop_v01.webp",
    "backdrop_v01.jpg",
    "backdrop_v01.jpeg"
]


static func load_for_scene(scene_id: String) -> Texture2D:
    if scene_id.is_empty():
        return null

    for file_name in CANDIDATE_FILENAMES:
        var path := "%s/%s/%s" % [ROOT_PATH, scene_id, file_name]
        if not ResourceLoader.exists(path):
            continue

        var resource = load(path)
        if resource is Texture2D:
            return resource

    return null
