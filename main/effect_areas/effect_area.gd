class_name EffectArea extends Node2D


@export var sensor: Sensor

@export var effects_on_entered: Array[Effect]


var active:= false



func initialize() -> void:

	sensor.initialize()




func activate() -> void:

	active = true



func deactivate() -> void:

	active = false