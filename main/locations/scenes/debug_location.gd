class_name DebugLocation extends Location




func initialize() -> bool:

	if not super():

		return false

	add_entity(Game.player, Vector2(100.0, 100.0))

	return true