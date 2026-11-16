class_name State extends Node






var active:= false

var entity: Entity






func initialize(_entity: Entity) -> void:

	entity = _entity




func reset() -> void:

	entity = null






func activate() -> void:

	active = true




func deactivate() -> void:

	active = false




func tick(_delta: float) -> void:

	pass