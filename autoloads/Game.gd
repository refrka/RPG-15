extends Node


signal game_state_changed(new_state: GameState)


enum LaunchMode {

	DEBUG,

	NORMAL,

}


enum GameState {

	MAIN_MENU,

	ACTIVE,

	PAUSED,

	CUTSCENE,

}


var player: Player:

	get:

		if not player:

			player = get_tree().get_first_node_in_group("player")

			if not player:

				player = load("res://main/entities/player/player.tscn").instantiate()

				hold_player()

		return player



var root: Node:

	get:

		if not root:

			root = get_tree().get_first_node_in_group("root")

		return root



var camera: Camera2D:

	get:

		if not camera:

			camera = get_tree().get_first_node_in_group("game_camera")

		return camera



var game_state: GameState






func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS



func start(launch_mode: LaunchMode) -> void:

	match launch_mode:

		LaunchMode.DEBUG:

			Scenes.load_location_scene("debug_location")

			Scenes.current_location.activate()

			set_game_state(GameState.ACTIVE)

		LaunchMode.NORMAL:

			UI.hide_hud()

			var main_menu = UI.get_overlay(MainMenu)

			UI.add_overlay(main_menu)

			set_game_state(GameState.MAIN_MENU)





func load_save() -> void:

	var main_menu = UI.get_overlay(MainMenu)

	UI.remove_overlay(main_menu)

	load_save_data()

	Scenes.current_location.activate()

	UI.show_hud()

	set_game_state(GameState.ACTIVE)




func save_game() -> void:

	var save_dict = collect_save_data()

	Saves.write_dict_to_file(save_dict)




func pause() -> void:

	get_tree().paused = true

	set_game_state(GameState.PAUSED)



func unpause() -> void:

	get_tree().paused = false

	set_game_state(GameState.ACTIVE)



func is_paused() -> bool:

	return game_state == GameState.PAUSED




func hold_player() -> void:

	var current_parent = player.get_parent()

	if not current_parent == self:

		if player.is_inside_tree():

			player.reparent(self)

		else:

			add_child(player)






func set_game_state(_game_state: GameState) -> void:

	game_state = _game_state

	game_state_changed.emit(game_state)







func load_save_data() -> void:

	var dict = Saves.last_save_dict.duplicate()

	Game.player.saved_spawn_id = dict["spawn_id"]

	Scenes.load_location_scene(dict["location_id"])





func collect_save_data() -> Dictionary:

	var dict = Saves.last_save_dict.duplicate()

	dict["location_id"] = Scenes.current_location.location_id

	dict["spawn_id"] = Game.player.spawn_id

	dict["known_recipes"] = Game.player.known_recipes

	return dict