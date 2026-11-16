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



var game_state: GameState






func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS



func start(launch_mode: LaunchMode) -> void:

	match launch_mode:

		LaunchMode.DEBUG:

			Scenes.load_location_scene("debug_location")

	set_game_state(GameState.ACTIVE)




func pause() -> void:

	get_tree().paused = true

	set_game_state(GameState.PAUSED)



func resume() -> void:

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