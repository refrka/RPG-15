class_name DetachCameraFromPlayerCommand extends Command








func execute(_data:= {}) -> Result:

	super(_data)

	if Game.camera.get_parent() == Game.player:

		Game.camera.reparent(Game.root)

		Game.camera.global_position = Vector2.ZERO

	result = Result.SUCCESS

	return result




static func run(_data:= {}) -> Command:

	var command = DetachCameraFromPlayerCommand.new()

	command.execute(_data)

	return command