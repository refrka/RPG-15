class_name InteractionComponent extends Component




var current_interactable: Entity

var current_interactable_component: InteractableComponent




func initialize(_entity: Entity) -> void:

	super(_entity)

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_updated.connect(_on_face_dir_updated)






func try_interaction() -> void:

	var interactable_entities = get_interactable_entities()

	if interactable_entities.is_empty():

		return

	var interactable = interactable_entities.pop_back()

	var interactable_component = interactable.get_interactable_component()

	while not interactable_entities.is_empty() and not interactable_component.can_interact():

		interactable = interactable_entities.pop_back()

		interactable_component = interactable.get_interactable_component()

	if not interactable and not interactable_component:

		return

	start_interaction(interactable, interactable_component)





func try_end_interaction() -> void:

	if current_interactable_component.can_end():

		end_interaction()




func start_interaction(interactable: Entity, interactable_component: InteractableComponent) -> void:

	entity.state_machine.request_state(BodyInteractingState)

	current_interactable = interactable

	current_interactable_component = interactable_component

	current_interactable_component.completed.connect(_on_current_interaction_completed)

	current_interactable_component.closed.connect(_on_current_interaction_closed)

	current_interactable_component.start()





func end_interaction() -> void:

	current_interactable_component.end()

	close_interaction()




func complete_interaction() -> void:

	current_interactable_component.complete()

	close_interaction()






func close_interaction() -> void:

	entity.state_machine.request_state(BodyIdleState)

	if current_interactable_component.completed.is_connected(_on_current_interaction_completed):

		current_interactable_component.completed.disconnect(_on_current_interaction_completed)

	if current_interactable_component.closed.is_connected(_on_current_interaction_closed):

		current_interactable_component.closed.disconnect(_on_current_interaction_closed)

	current_interactable = null

	current_interactable_component = null







func is_interacting() -> bool:

	return entity.state_machine.current_body_state is BodyInteractingState




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

	return dist1 > dist2




func _on_face_dir_updated(dir: Vector2) -> void:

	entity.interaction_sensor.rotation = dir.angle()




func _on_current_interaction_completed() -> void:

	end_interaction()



func _on_current_interaction_closed() -> void:

	close_interaction()



func _on_current_interaction_ended() -> void:

	end_interaction()




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact") and Inputs.is_action_allowed("interact"):

		if is_interacting():

			try_end_interaction()

		else:
	
			try_interaction()




