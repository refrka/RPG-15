class_name MovementComponent extends Component


signal face_dir_updated(dir: Vector2)


var move_dir: Vector2

var face_dir: Vector2

var move_speed:= 0.0


var modifier_tracker:= ModifierTracker.new()



var move_locked:= false

var turn_locked:= false






func get_move_dir() -> Vector2:

	return Vector2.ZERO




func set_face_dir(dir: Vector2) -> void:

	if dir != face_dir and dir != Vector2.ZERO and not turn_locked:

		face_dir = dir

		face_dir_updated.emit(dir)




func get_velocity(delta: float) -> Vector2:

	move_dir = get_move_dir()

	move_speed = get_move_speed()

	var move_velocity = move_dir * move_speed

	var velocity = move_velocity * delta

	return velocity




func get_move_speed() -> float:

	return 5000.0





func _physics_process(delta: float) -> void:

	var current_velocity = entity.velocity

	var new_velocity = get_velocity(delta)

	set_face_dir(new_velocity.normalized())

	entity.velocity = current_velocity.move_toward(new_velocity, 30.0)

	entity.move_and_slide()