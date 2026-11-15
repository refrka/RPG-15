class_name MovementComponent extends Component


signal face_dir_updated(dir: Vector2)



var move_dir: Vector2

var face_dir: Vector2


var modifier_tracker:= ModifierTracker.new()









func set_face_dir(dir: Vector2) -> void:

	if dir != face_dir and dir != Vector2.ZERO:

		dir = face_dir

		face_dir_updated.emit(dir)






func move(dir: Vector2) -> void:

	move_dir = dir

	entity.move_and_slide()





func _physics_process(delta: float) -> void:

	return