class_name PlayerMovementComponent extends MovementComponent



var move_left_pressed:= false

var move_right_pressed:= false

var move_up_pressed:= false

var move_down_pressed:= false





func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS




func get_move_dir() -> Vector2:

	var dir:= Vector2.ZERO

	if move_left_pressed:

		dir += Vector2.LEFT

	if move_right_pressed:

		dir += Vector2.RIGHT

	if move_up_pressed:

		dir += Vector2.UP

	if move_down_pressed:

		dir += Vector2.DOWN

	return dir.normalized()




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action("move_left") and Inputs.is_action_allowed("move_left"):

		move_left_pressed = event.is_pressed()

	if event.is_action("move_right") and Inputs.is_action_allowed("move_right"):

		move_right_pressed = event.is_pressed()

	if event.is_action("move_up") and Inputs.is_action_allowed("move_up"):

		move_up_pressed = event.is_pressed()

	if event.is_action("move_down") and Inputs.is_action_allowed("move_down"):

		move_down_pressed = event.is_pressed()