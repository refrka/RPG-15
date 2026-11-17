class_name InteractionComponent extends Component






func initialize(_entity: Entity) -> void:

	super(_entity)

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_updated.connect(_on_face_dir_updated)






func try_interaction() -> void:

	var interactable_entities = get_interactable_entities()

	if interactable_entities.is_empty():

		return





func get_interactable_entities() -> Array:

	var entities = []

	for _entity in entity.interaction_sensor.entities:

		var interactable_component = get_interactable_component(_entity)
		
		if interactable_component:

			entities.append(_entity)

	entities.sort_custom(_sort_nearest_interactable)

	return entities





func get_interactable_component(_entity: Entity) -> InteractableComponent:

	for component in _entity.components.values():

		if component is InteractableComponent:

			return component

	return null





func _sort_nearest_interactable(e1: Entity, e2: Entity) -> bool:

	var dist1 = entity.global_position.distance_squared_to(e1.global_position)

	var dist2 = entity.global_position.distance_squared_to(e2.global_position)

	return dist1 < dist2




func _on_face_dir_updated(dir: Vector2) -> void:

	entity.interaction_sensor.rotation = dir.angle()






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact") and Inputs.is_action_allowed("interact"):

		try_interaction()




