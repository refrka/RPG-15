class_name IsFlagCondition extends Condition


@export var flag: String

@export var value: bool




func evaluate(_data:= {}) -> bool:

	if _data.has("flag"):

		flag = _data.flag

	if _data.has("value"):

		value = _data.value

	return Global.get_flag(flag) == value