class_name VisionSensor extends Sensor



signal entity_position_updated(entity: Entity, position: Vector2)


@export var ray: RayCast2D

@export var target_whitelist: Array[EntityRef]

@export var target_blacklist: Array[EntityRef]


var known_entities: Dictionary[Entity, Vector2]

var update_timer:= 0.5



func initialize(_entity: Entity = null) -> void:

	super(_entity)

	entity_entered.connect(_on_entity_entered)






func is_target_valid(target: Entity) -> bool:

	if not target_whitelist.is_empty():

		for ref in target_whitelist:

			if ref.matches(target):

				return true

		return false

	if not target_blacklist.is_empty():

		for ref in target_blacklist:

			if ref.matches(target):

				return false

	return true




func is_target_visible(target: Entity) -> bool:

	ray.target_position = target.global_position - entity.global_position

	ray.force_raycast_update()

	if not ray.is_colliding():

		return true

	return false



func get_target_position(target: Entity) -> Vector2:

	if known_entities.has(target):

		return known_entities[target]

	return Vector2.INF



func update_known_position(target: Entity) -> void:

	if not known_entities.has(target):

		target.died.connect(_on_target_died.bind(target))

	known_entities[target] = target.global_position

	entity_position_updated.emit(target, target.global_position)




func _on_entity_entered(visible_entity: Entity) -> void:

	if is_target_visible(visible_entity):

		update_known_position(visible_entity)




func _on_target_died(target: Entity) -> void:

	if known_entities.has(target):

		known_entities.erase(target)



func _process(delta: float) -> void:

	if not active:

		return

	update_timer -= delta

	if update_timer <= 0.0:

		for target in known_entities:

			if is_target_visible(target):

				update_known_position(target)

		update_timer = 0.5


