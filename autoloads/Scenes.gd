extends Node




var location_root: Node2D:

	get:

		if not location_root:

			location_root = get_tree().get_first_node_in_group("location_root")

		return location_root



var location_scenes: Dictionary[StringName, PackedScene]


var current_location: Location







func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS







func load_location_scene(location_id: StringName) -> void:

	if not location_scenes.has(location_id):

		return

	if current_location:

		current_location.deactivate()

		location_root.remove_child(current_location)

	current_location = location_scenes[location_id].instantiate()

	location_root.add_child(current_location)

	current_location.initialize()

	current_location.activate()
