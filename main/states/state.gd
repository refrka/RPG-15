class_name State extends Node






var active:= false

var entity: Entity






func initialize(_entity: Entity) -> void:

	entity = _entity




func reset() -> void:

	entity = null






func enter() -> void:

	active = true




func exit() -> void:

	active = false




func tick(_delta: float) -> void:

	pass