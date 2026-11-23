class_name GenerateNoticeCommand extends Command


@export var message: String


func execute(_data:= {}) -> Result:

	super(_data)

	if _data.has("message"):

		message = _data.message

	Notices.new_notice(message)

	result = Result.SUCCESS

	return result