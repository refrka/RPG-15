class_name Command extends Resource


@warning_ignore("unused_signal")

signal command_executed

signal command_cancelled


enum Result {

	PENDING,

	SUCCESS,

	FAILURE,

	CANCELLED,

}


var data:= {}

var result: Result

var actor: Entity




func execute(_data:= {}) -> Result:

	data = _data

	if data.has("actor"):

		actor = data.actor

	result = Result.SUCCESS

	return result




func cancel() -> void:

	result = Result.CANCELLED

	command_cancelled.emit()




static func run(_data:= {}) -> Command:

	return null