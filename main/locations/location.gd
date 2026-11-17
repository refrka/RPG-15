class_name Location extends Node2D


enum LocationState {

	ACTIVE,

	INACTIVE,

	CUSTSCENE

}


@export var entity_root: Node2D

@export var projectile_root: Node2D

var location_state: LocationState

var initialized:= false






func initialize() -> bool:

	if initialized:

		return false

	initialized = true

	entity_root.get_children().map(func(e): e.initialize())

	return true






func activate() -> void:

	set_location_state(LocationState.ACTIVE)

	entity_root.get_children().map(func(e): e.activate())



func deactivate() -> void:

	set_location_state(LocationState.INACTIVE)

	entity_root.get_children().map(func(e): e.activate())




func add_entity(entity: Entity, target_position: Vector2) -> void:

	var current_parent = entity.get_parent()

	if current_parent != entity_root and current_parent != null:

		current_parent.remove_child(entity)

	entity_root.add_child(entity)

	entity.global_position = target_position

	entity.initialize()

	if location_state == LocationState.ACTIVE:

		entity.activate()





func set_location_state(_location_state: LocationState) -> void:

	location_state = _location_state