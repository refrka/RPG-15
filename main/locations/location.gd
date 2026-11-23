class_name Location extends Node2D


enum LocationState {

	ACTIVE,

	INACTIVE,

	CUSTSCENE

}

@export var location_id: StringName

@export var entity_root: Node2D

@export var projectile_root: Node2D

@export var pickup_root: Node2D

@export var feature_root: Node2D

var location_state: LocationState

var initialized:= false






func initialize() -> bool:

	if initialized:

		return false

	initialized = true

	entity_root.get_children().map(func(e): e.initialize())

	feature_root.get_children().map(func(f): f.initialize())

	return true






func activate() -> void:

	set_location_state(LocationState.ACTIVE)

	entity_root.get_children().map(func(e): e.activate())

	feature_root.get_children().map(func(f): f.activate())




func deactivate() -> void:

	set_location_state(LocationState.INACTIVE)

	entity_root.get_children().map(func(e): e.deactivate())

	feature_root.get_children().map(func(f): f.deactivate())






func add_entity(entity: Entity, target_position: Vector2) -> void:

	var current_parent = entity.get_parent()

	if current_parent != entity_root and current_parent != null:

		current_parent.remove_child(entity)

	entity_root.add_child(entity)

	entity.global_position = target_position

	entity.initialize()

	if location_state == LocationState.ACTIVE:

		entity.activate()




func add_pickup(pickup: Pickup, origin: Vector2, move_out:= true) -> void:

	pickup_root.add_child.call_deferred(pickup)

	pickup.global_position = origin

	var dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

	if move_out:

		var tween = get_tree().create_tween()

		tween.tween_property(pickup, "global_position", origin + (dir * 16.0), 0.5)



func spawn_player(spawn_id: StringName) -> void:

	var spawn_point = get_feature(spawn_id)

	if spawn_point:

		Game.hold_player()

		Game.player.global_position = spawn_point.global_position

		Game.player.reparent(entity_root)

		AttachCameraToPlayerCommand.run()




func get_feature(feature_id: StringName) -> Feature:

	for child in feature_root.get_children():

		if child.feature_id == feature_id:

			return child

	return null



func get_entities_by_entity_id(entity_id: StringName) -> Array:

	var entities = []

	for entity in entity_root.get_children():

		if entity.entity_id == entity_id:

			entities.append(entity)

	return entities



func set_location_state(_location_state: LocationState) -> void:

	location_state = _location_state