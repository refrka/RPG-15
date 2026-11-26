class_name BodyMovingState extends BodyState




var anim_check_timer:= 0.2



func enter() -> void:

	super()

	movement_component.move_started.connect(_on_move_started)

	movement_component.move_ended.connect(_on_move_ended)

	entity.face_dir_updated.connect(_on_face_dir_updated)

	if movement_component.move_dir != Vector2.ZERO:

		var anim_name = "%s/move_%s" % [entity.entity_id, "down" if entity.face_dir.y >= 0 else "up"]

		animation_component.play_body_animation(anim_name)






func exit() -> void:

	super()

	movement_component.move_started.disconnect(_on_move_started)

	movement_component.move_ended.disconnect(_on_move_ended)

	entity.face_dir_updated.disconnect(_on_face_dir_updated)






func _on_face_dir_updated(dir: Vector2) -> void:

	var anim_name = "%s/move_%s" % [entity.entity_id, "down" if dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)







func _on_move_started() -> void:

	_on_face_dir_updated(movement_component.move_dir)



func _on_move_ended() -> void:

	entity.state_machine.request_state(BodyIdleState)





func tick(delta: float) -> void:

	anim_check_timer -= delta

	if anim_check_timer <= 0.0:
	
		if not entity.body_anim_player.current_animation.contains("move"):

			var anim_name = "%s/move_%s" % [entity.entity_id, "down" if entity.face_dir.y >= 0 else "up"]

			animation_component.play_body_animation(anim_name)

			return

		if movement_component.move_dir == Vector2.ZERO:

			state_machine.request_state(BodyIdleState)

			return

		anim_check_timer = 0.2