class_name Command extends Resource


@warning_ignore("unused_signal")

signal command_executed


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

	return Result.SUCCESS






static func run(_data:= {}) -> Command:

	return null