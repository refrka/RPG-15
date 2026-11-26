class_name State extends Node






var active:= false

var state_machine: StateMachine

var entity: Entity






func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	entity = _entity

	state_machine = _state_machine




func reset() -> void:

	entity = null






func enter() -> void:

	active = true




func exit() -> void:

	active = false




func tick(_delta: float) -> void:

	pass