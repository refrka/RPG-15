class_name AddToolToPlayerInventoryCommand extends Command


@export var tool: Tool


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("tool"):

		tool = data.tool

	if not Game.player.inventory.tools.has(tool):

		Game.player.inventory.tools.append(tool)

	result = Result.SUCCESS

	return result