class_name MoveToTargetPositionCommand extends Command




@export var target_position: Vector2


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("target_position"):

		target_position = data.target_position

	var movement_component = actor.get_component(MovementComponent)

	movement_component.set_target_position(target_position)

	movement_component.target_position_reached.connect(_on_target_position_reached)
	
	result = Result.PENDING

	return result




func _on_target_position_reached() -> void:

	result = Result.SUCCESS

	command_executed.emit()