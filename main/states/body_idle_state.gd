class_name BodyIdleState extends BodyState






func initialize(_entity: Entity) -> void:

	super(_entity)




func enter() -> void:

	super()

	if movement_component:

		movement_component.move_started.connect(_on_move_started)

	var anim_name = "%s/idle_%s" % [entity.entity_id, "down" if entity.face_dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)





func exit() -> void:

	super()

	if movement_component:

		movement_component.move_started.disconnect(_on_move_started)





func _on_move_started() -> void:

	entity.state_machine.request_state(BodyMovingState)
