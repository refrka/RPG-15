class_name SetFlagCommand extends Command


@export var flag: String

@export var value: bool



func execute(_data:= {}) -> Result:

	super(_data)

	if _data.has("flag"):

		flag = _data.flag

	if _data.has("value"):

		value = _data.value

	Global.set_flag(flag, value)

	result = Result.SUCCESS

	return result