class_name BodyIdleState extends BodyState








func enter() -> void:

	super()

	if movement_component:

		if movement_component.move_dir != Vector2.ZERO:

			state_machine.request_state(BodyMovingState)

			return

		movement_component.move_started.connect(_on_move_started)

	var anim_name = "%s/idle_%s" % [entity.entity_id, "down" if entity.face_dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)





func exit() -> void:

	super()

	if movement_component and movement_component.move_started.is_connected(_on_move_started):

		movement_component.move_started.disconnect(_on_move_started)





func _on_move_started() -> void:

	entity.state_machine.request_state(BodyMovingState)
