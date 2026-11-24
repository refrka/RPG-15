class_name MovementComponent extends Component


signal face_dir_updated(dir: Vector2)

signal move_started

signal move_ended

signal target_position_reached



enum MovementState {

	DIR,

	TARGET,

}



@export var dir_ray: RayCast2D

var movement_state: MovementState

var move_dir: Vector2

var move_velocity: Vector2

var move_speed:= 0.0


var target_position:= Vector2.ZERO




var modifier_tracker:= ModifierTracker.new()



var move_locked:= false

var turn_locked:= false

var nav_enabled:= true




func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.nav_agent.navigation_finished.connect(_on_target_position_reached)






func halt() -> void:

	movement_state = MovementState.DIR

	target_position = Vector2.INF

	entity.velocity = Vector2.ZERO

	move_velocity = Vector2.ZERO






func get_move_dir() -> Vector2:

	var dir = Vector2.ZERO

	match movement_state:

		MovementState.DIR:

			return Vector2.ZERO

		MovementState.TARGET:

			if target_position != Vector2.INF:

				dir = entity.global_position.direction_to(entity.nav_agent.get_next_path_position())

	if move_dir == Vector2.ZERO and dir != Vector2.ZERO:

		move_started.emit()

	move_dir = dir

	entity.set_face_dir(dir)

	return dir






func set_target_position(_target_position: Vector2) -> void:

	target_position = _target_position

	movement_state = MovementState.TARGET

	if nav_enabled:

		entity.nav_agent.target_position = target_position
	



func clear_target_position() -> void:

	target_position = Vector2.INF

	movement_state = MovementState.DIR






func get_velocity(delta: float) -> Vector2:

	if move_locked:

		return Vector2.ZERO

	move_dir = get_move_dir()

	move_speed = get_move_speed()

	move_velocity = move_dir * move_speed * delta

	var modifier_velocity = modifier_tracker.get_vector()

	move_velocity += modifier_velocity

	return move_velocity




func get_move_speed() -> float:

	var speed_multipler = modifier_tracker.get_float_multiply()

	var speed_add = modifier_tracker.get_float_add()

	return (entity.stats.move_speed + speed_add) * speed_multipler





func _on_damage_package_received(damage_package: DamagePackage) -> void:

	if damage_package.attack_entry.knockback_force > 0.0:

		var value = damage_package.source_dir * damage_package.attack_entry.knockback_force

		if entity.stats.knockback_resistance > 0.0:

			value *= (1.0 - entity.stats.knockback_resistance)

		var modifier = Modifier.new_decay(value, 10.0, Modifier.Operator.ADD)

		modifier_tracker.add_modifier(modifier)




func _on_target_position_reached() -> void:

	clear_target_position()

	target_position_reached.emit()




func _on_death() -> void:

	if movement_state == MovementState.TARGET:

		clear_target_position()





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

	modifier_tracker.tick(delta)

	if movement_state == MovementState.TARGET:

		if entity.global_position.distance_to(target_position) <= 5.0:

			_on_target_position_reached()