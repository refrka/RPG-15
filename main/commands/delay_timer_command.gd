class_name DelayTimerCommand extends Command



@export var duration:= 1.0


var timer: SceneTreeTimer



func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("duration"):

		duration = data.duration

	timer = Game.get_tree().create_timer(duration)

	timer.timeout.connect(_on_timeout)

	result = Result.PENDING

	return result




func cancel() -> void:

	if timer:

		timer.timeout.disconnect(_on_timeout)

		timer = null

	super()





func _on_timeout() -> void:

	timer = null

	result = Result.SUCCESS

	command_executed.emit()