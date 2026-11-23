class_name GiveToolToPlayerCommand extends Command


@export var tool: Tool




func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("tool"):

		tool = data.tool

	Game.player.inventory.add_tool(tool)

	result = Result.SUCCESS

	return result