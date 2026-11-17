class_name BodyMovingState extends BodyState





func enter() -> void:

	super()

	movement_component.move_ended.connect(_on_move_ended)

	movement_component.face_dir_updated.connect(_on_face_dir_updated)

	var anim_name = "%s/move_%s" % [entity.entity_id, "down" if movement_component.face_dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)






func exit() -> void:

	super()

	movement_component.move_ended.disconnect(_on_move_ended)

	movement_component.face_dir_updated.disconnect(_on_face_dir_updated)




func _on_face_dir_updated(dir: Vector2) -> void:

	var anim_name = "%s/move_%s" % [entity.entity_id, "down" if dir.y >= 0 else "up"]

	animation_component.play_body_animation(anim_name)





func _on_move_ended() -> void:

	entity.state_machine.request_state(BodyIdleState)