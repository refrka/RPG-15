class_name MovementComponent extends Component


signal face_dir_updated(dir: Vector2)

signal move_started

signal move_ended


@export var dir_ray: RayCast2D


var move_dir: Vector2

var face_dir:= Vector2.RIGHT

var move_velocity: Vector2

var move_speed:= 0.0


var modifier_tracker:= ModifierTracker.new()



var move_locked:= false

var turn_locked:= false






func get_move_dir() -> Vector2:

	return Vector2.ZERO




func set_face_dir(dir: Vector2) -> void:

	if dir != face_dir and dir != Vector2.ZERO and not turn_locked:

		face_dir = dir

		dir_ray.rotation = dir.angle()

		face_dir_updated.emit(dir)




func get_face_dir_string() -> String:

	if face_dir == Vector2.RIGHT:

		return "right"

	if face_dir == Vector2.LEFT:

		return "left"

	if face_dir == Vector2.UP:

		return "up"

	if face_dir == Vector2.DOWN:

		return "down"

	return ""




func get_velocity(delta: float) -> Vector2:

	if move_locked:

		return Vector2.ZERO

	move_dir = get_move_dir()

	move_speed = get_move_speed()

	move_velocity = move_dir * move_speed * delta

	return move_velocity




func get_move_speed() -> float:

	return 4000.0





func _physics_process(delta: float) -> void:

	if not active:

		return

	var current_velocity = entity.velocity

	var new_velocity = get_velocity(delta)

	new_velocity = current_velocity.move_toward(new_velocity, 30.0)

	if new_velocity != Vector2.ZERO and entity.velocity == Vector2.ZERO:

		move_started.emit()

	if new_velocity == Vector2.ZERO and current_velocity != Vector2.ZERO:

		move_ended.emit()

	entity.velocity = new_velocity

	entity.move_and_slide()