extends Node



@export var input_configs: Array[InputConfig]

@export var launch_mode: Game.LaunchMode

@export var location_scenes: Dictionary[StringName, PackedScene]



func _ready() -> void:

	Inputs.input_configs = input_configs

	Scenes.location_scenes = location_scenes

	Game.start(launch_mode)