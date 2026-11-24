class_name PlayerMovementComponent extends MovementComponent



var move_left_pressed:= false

var move_right_pressed:= false

var move_up_pressed:= false

var move_down_pressed:= false





func initialize(_entity: Entity) -> void:

	super(_entity)

	nav_enabled = false





func get_move_dir() -> Vector2:

	var dir:= Vector2.ZERO

	var _face_dir:= Vector2.ZERO

	if move_left_pressed:

		dir += Vector2.LEFT

		if not move_right_pressed:

			if _face_dir == Vector2.ZERO:

				_face_dir = Vector2.LEFT

	if move_right_pressed:

		dir += Vector2.RIGHT

		if not move_left_pressed:

			if _face_dir == Vector2.ZERO:

				_face_dir = Vector2.RIGHT

	if move_up_pressed:

		dir += Vector2.UP

		if not move_right_pressed and not move_left_pressed and not move_down_pressed:

			if _face_dir == Vector2.ZERO:

				_face_dir = Vector2.UP

	if move_down_pressed:

		dir += Vector2.DOWN

		if not move_right_pressed and not move_up_pressed and not move_left_pressed:

			if _face_dir == Vector2.ZERO:

				_face_dir = Vector2.DOWN

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_dir == Vector2.ZERO and dir != Vector2.ZERO:

		dir = input_dir

		refresh_inputs()

	entity.set_face_dir(_face_dir)

	if move_dir == Vector2.ZERO and dir != Vector2.ZERO:

		move_started.emit()

	move_dir = dir.normalized()

	return dir.normalized()




func refresh_inputs() -> void:

	move_left_pressed = Input.is_action_pressed("move_left")

	move_right_pressed = Input.is_action_pressed("move_right")

	move_up_pressed = Input.is_action_pressed("move_up")

	move_down_pressed = Input.is_action_pressed("move_down")




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action("move_left") and Inputs.is_action_allowed("move_left"):

		move_left_pressed = event.is_pressed()

	if event.is_action("move_right") and Inputs.is_action_allowed("move_right"):

		move_right_pressed = event.is_pressed()

	if event.is_action("move_up") and Inputs.is_action_allowed("move_up"):

		move_up_pressed = event.is_pressed()

	if event.is_action("move_down") and Inputs.is_action_allowed("move_down"):

		move_down_pressed = event.is_pressed()