class_name ToolRect extends TextureRect

@export var tool: Tool







func update() -> void:

	if Game.player.inventory.tools.has(tool):

		modulate.a = 1.0

	else:

		modulate.a = 0.1