class_name BodyInteractingState extends BodyBusyState


var interaction_component: InteractionComponent


func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	interaction_component = entity.get_component(InteractionComponent)




func enter() -> void:

	super()

	if movement_component:

		movement_component.halt()

	var anim_name = "%s/idle_%s" % [entity.entity_id, "down" if entity.face_dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)

	if interaction_component.current_interactable_component and interaction_component.current_interactable_component.required_tool:

		entity.tool_icon_rect.texture = interaction_component.current_interactable_component.required_tool.icon_texture

		entity.tool_icon_rect.anim_player.play("use")





func exit() -> void:

	super()

	entity.tool_icon_rect.anim_player.play("RESET")