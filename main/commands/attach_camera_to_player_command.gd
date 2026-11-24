class_name AttachCameraToPlayerCommand extends Command






func execute(_data:= {}) -> Result:

	super(_data)

	if not Game.camera.get_parent() == Game.player:

		Game.camera.reparent(Game.player)

		Game.camera.global_position = Game.player.global_position

	Game.camera.limit_left = int(Scenes.current_location.camera_top_left_limit.global_position.x)

	Game.camera.limit_top = int(Scenes.current_location.camera_top_left_limit.global_position.y)

	Game.camera.limit_right = int(Scenes.current_location.camera_bottom_right_limit.global_position.x)

	Game.camera.limit_bottom = int(Scenes.current_location.camera_bottom_right_limit.global_position.x)

	result = Result.SUCCESS

	return result




	

static func run(_data:= {}) -> Command:

	var command = AttachCameraToPlayerCommand.new()

	command.execute(_data)

	return command