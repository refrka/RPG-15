class_name ChooseRandomTargetPositionCommand extends Command



@export var target_range:= 50.0

@export var x_range:= Vector2(-1.0, 1.0)

@export var y_range:= Vector2(-1.0, 1.0)



func execute(_data:= {}) -> Result:

	super(_data)

	var dir = Vector2(randf_range(x_range.x, x_range.y), randf_range(y_range.x, y_range.y))

	var relative_pos = dir * target_range

	data["target_position"] = actor.global_position + relative_pos

	result = Result.SUCCESS

	return result