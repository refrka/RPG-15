class_name MoveToTargetPositionCommand extends Command




@export var target_position: Vector2

@export var move_speed_override:= -1.0

var move_speed_modifier: Modifier


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("target_position"):

		target_position = data.target_position

	var movement_component = actor.get_component(MovementComponent)

	movement_component.set_target_position(target_position)

	movement_component.target_position_reached.connect(_on_target_position_reached, CONNECT_ONE_SHOT)

	if move_speed_override > 0.0:

		move_speed_modifier = Modifier.new_passive(move_speed_override, Modifier.Operator.OVERRIDE)

		movement_component.modifier_tracker.add_modifier(move_speed_modifier)
	
	result = Result.PENDING

	return result





func cancel() -> void:

	if move_speed_modifier:

		move_speed_modifier.expire()

	var movement_component = actor.get_component(MovementComponent)

	movement_component.halt()

	super()





func _on_target_position_reached() -> void:

	if move_speed_modifier:

		move_speed_modifier.expire()

	result = Result.SUCCESS

	command_executed.emit()