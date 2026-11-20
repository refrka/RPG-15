extends Node



@export var input_configs: Array[InputConfig]

@export var launch_mode: Game.LaunchMode

@export var location_scenes: Dictionary[StringName, PackedScene]



func _ready() -> void:

	Inputs.input_configs = input_configs

	Scenes.location_scenes = location_scenes

	Game.start(launch_mode)

	drop()

	drop()

	drop()

	drop()

	drop()

	drop()

	drop()

	drop()



func drop() -> void:

	var item = load("res://main/items/valuables/coin.tres")

	var stack = ItemStack.create(item, 1)

	var pickup = Pickup.create(stack)

	Scenes.current_location.add_pickup(pickup, Vector2(50.0, 50.0))