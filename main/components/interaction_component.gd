class_name InteractionComponent extends Component




var current_interactable: Entity

var current_interactable_component: InteractableComponent


var nearest_interactable: Entity




func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.face_dir_updated.connect(_on_face_dir_updated)

	entity.interaction_sensor.entity_entered.connect(_on_entity_entered_interaction_sensor)

	entity.interaction_sensor.entity_exited.connect(_on_entity_exited_interaction_sensor)






func try_interaction() -> void:

	var interactable_entities = get_interactable_entities()

	if interactable_entities.is_empty():

		return

	var interactable = interactable_entities.pop_back()

	var interactable_component = interactable.get_interactable_component()

	while not is_instance_valid(interactable) and not interactable_entities.is_empty() and not interactable_component.can_interact():

		interactable = interactable_entities.pop_back()

		interactable_component = interactable.get_interactable_component()

	if not is_instance_valid(interactable_component):

		Dialogue.try_dialogue(interactable)

		return

	if interactable_component.required_tool and not entity.inventory.tools.has(interactable_component.required_tool):

		interactable_component._on_failed_interaction()

		return

	if not interactable_component.can_interact():

		return

	if not interactable and not interactable_component:

		return

	start_interaction(interactable, interactable_component)





func try_end_interaction() -> void:

	if current_interactable and not current_interactable_component.can_end():

		return

	end_interaction(false)





func set_nearest_interactable(interactable: Entity) -> void:

	if nearest_interactable == interactable:

		return

	nearest_interactable = interactable

	entity.tool_icon_rect.texture = null

	entity.tool_icon_rect.modulate.a = 1.0

	if not nearest_interactable:

		return

	var interactable_component = nearest_interactable.get_interactable_component()

	if interactable_component and interactable_component.required_tool and interactable_component.can_interact():

		entity.tool_icon_rect.texture = interactable_component.required_tool.icon_texture

		if not entity.inventory.tools.has(interactable_component.required_tool):

			entity.tool_icon_rect.modulate.a = 0.15

		

	



func start_interaction(interactable: Entity, interactable_component: InteractableComponent) -> void:

	current_interactable = interactable

	current_interactable_component = interactable_component

	entity.state_machine.request_state(BodyInteractingState)

	current_interactable_component.completed.connect(_on_current_interaction_completed)

	current_interactable_component.closed.connect(_on_current_interaction_closed)

	current_interactable_component.cancelled.connect(_on_current_interaction_cancelled)

	current_interactable_component.ended.connect(_on_current_interaction_ended)

	current_interactable_component.start()





func end_interaction(retry:= true) -> void:

	current_interactable_component.end()

	close_interaction(retry)





func close_interaction(retry:= true) -> void:

	entity.tool_icon_rect.texture = null

	if entity.is_alive():

		entity.state_machine.request_state(BodyIdleState)

	if current_interactable_component.completed.is_connected(_on_current_interaction_completed):

		current_interactable_component.completed.disconnect(_on_current_interaction_completed)

	if current_interactable_component.closed.is_connected(_on_current_interaction_closed):

		current_interactable_component.closed.disconnect(_on_current_interaction_closed)

	if current_interactable_component.cancelled.is_connected(_on_current_interaction_cancelled):

		current_interactable_component.cancelled.disconnect(_on_current_interaction_cancelled)

	if current_interactable_component.ended.is_connected(_on_current_interaction_ended):

		current_interactable_component.ended.disconnect(_on_current_interaction_ended)

	if retry:

		var interactable_entities = get_interactable_entities()

		if not interactable_entities.is_empty() and not interactable_entities.back() == current_interactable:

			if Input.is_action_pressed("interact") and Inputs.is_action_allowed("interact"):

				try_interaction()

	else:

		current_interactable = null

		current_interactable_component = null

	nearest_interactable = null

	set_nearest_interactable(get_nearest_interactable())




func cancel_interaction() -> void:

	close_interaction()





func is_interacting() -> bool:

	return entity.state_machine.current_body_state is BodyInteractingState




func get_interactable_entities() -> Array:

	var entities = []

	for _entity in entity.interaction_sensor.entities:

		var interactable_component = get_interactable_component(_entity)
		
		if interactable_component:

			entities.append(_entity)

		if _entity.dialogue_library and not entities.has(_entity):

			entities.append(_entity)

	entities.sort_custom(_sort_nearest_interactable)

	return entities





func get_interactable_component(_entity: Entity) -> InteractableComponent:

	for component in _entity.components.values():

		if component is InteractableComponent:

			return component

	return null




func get_nearest_interactable() -> Entity:
	
	var interactable_entities = get_interactable_entities()

	if interactable_entities.is_empty():

		return null

	return interactable_entities.pop_back()



func _sort_nearest_interactable(e1: Entity, e2: Entity) -> bool:

	var dist1 = entity.global_position.distance_squared_to(e1.global_position)

	var dist2 = entity.global_position.distance_squared_to(e2.global_position)

	return dist1 > dist2




func _on_face_dir_updated(dir: Vector2) -> void:

	entity.interaction_sensor.rotation = dir.angle()




func _on_current_interaction_completed() -> void:

	close_interaction()



func _on_current_interaction_closed() -> void:

	close_interaction()



func _on_current_interaction_ended() -> void:

	end_interaction()



func _on_current_interaction_cancelled() -> void:

	cancel_interaction()



	


func _on_death() -> void:

	if current_interactable and current_interactable_component:

		current_interactable_component.end()



func _on_entity_entered_interaction_sensor(_entity: Entity) -> void:

	set_nearest_interactable(get_nearest_interactable())

	if Input.is_action_pressed("interact") and Inputs.is_action_allowed("interact"):

		try_interaction()

		

func _on_entity_exited_interaction_sensor(_entity: Entity) -> void:

	set_nearest_interactable(get_nearest_interactable())






func _unhandled_input(event: InputEvent) -> void:

	if not active:

		return

	if event.is_action_pressed("interact") and Inputs.is_action_allowed("interact"):

		if is_interacting():

			try_end_interaction()

		else:
	
			try_interaction()

	if event.is_action_released("interact") and Inputs.is_action_allowed("interact"):

		if is_interacting() and current_interactable_component is HarvestComponent:

			if current_interactable_component.duration > 0.0:

				current_interactable_component.cancel()



