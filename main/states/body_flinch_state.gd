class_name BodyFlinchState extends BodyState









func enter() -> void:

	super()

	entity.body_anim_player.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

	if movement_component:

		movement_component.move_locked = true

	var anim_name = "%s/flinch" % entity.entity_id if entity.body_anim_player.has_animation("%s/flinch" % entity.entity_id) else "flinch"

	animation_component.play_body_animation(anim_name)



func exit() -> void:

	super()

	if entity.body_anim_player.animation_finished.is_connected(_on_animation_finished):

		entity.body_anim_player.animation_finished.disconnect(_on_animation_finished)

	if movement_component:

		movement_component.move_locked = false





func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name.ends_with("flinch"):

		state_machine.request_state(BodyIdleState)