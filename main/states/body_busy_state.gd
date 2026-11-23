class_name BodyBusyState extends BodyState





func enter() -> void:

	super()

	if movement_component:

		movement_component.move_locked = true

	var anim_name = "%s/idle_%s" % [entity.entity_id, "down" if movement_component.face_dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)





func exit() -> void:

	super()

	if movement_component:

		movement_component.move_locked = false