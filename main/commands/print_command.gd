class_name PrintCommand extends Command




@export var text: String



func execute(_data:= {}) -> Result:

	super(_data)

	print(text)

	result = Result.SUCCESS

	return result