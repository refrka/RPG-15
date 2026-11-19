class_name BodyBusyState extends BodyState





func enter() -> void:

	super()

	if movement_component:

		movement_component.move_locked = true





func exit() -> void:

	super()

	if movement_component:

		movement_component.move_locked = false