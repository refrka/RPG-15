class_name AttachCameraToPlayerCommand extends Command






func execute(_data:= {}) -> Result:

	super(_data)

	if not Game.camera.get_parent() == Game.player:

		Game.camera.reparent(Game.player)

		Game.camera.global_position = Game.player.global_position

	result = Result.SUCCESS

	return result




	

static func run(_data:= {}) -> Command:

	var command = AttachCameraToPlayerCommand.new()

	command.execute(_data)

	return command