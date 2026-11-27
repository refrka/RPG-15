extends Node




var location_root: Node2D:

	get:

		if not location_root:

			location_root = get_tree().get_first_node_in_group("location_root")

		return location_root


var cutscene_location_root: Node2D:

	get:

		if not cutscene_location_root:

			cutscene_location_root = get_tree().get_first_node_in_group("cutscene_cutscene_location_root")

		return location_root



var location_scenes: Dictionary[StringName, PackedScene]


var current_location: Location







func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS







func load_location_scene(location_id: StringName, spawn_id:= "default_spawn") -> void:

	if not location_scenes.has(location_id):

		return

	if current_location:

		current_location.deactivate()

		location_root.remove_child(current_location)

	current_location = location_scenes[location_id].instantiate()

	location_root.add_child(current_location)

	current_location.spawn_player(spawn_id)

	current_location.initialize()





func transition_to(location_id: StringName, spawn_id:= "default_spawn") -> void:

	Game.player.deactivate()

	var command = ModulateFGCommand.run({"before": 0.0, "after": 1.0})

	await command.command_executed

	Game.hold_player()

	load_location_scene(location_id, spawn_id)

	command = ModulateFGCommand.run({"before": 1.0, "after": 0.0, "initial_delay": 0.5})

	await command.command_executed

	current_location.activate()

