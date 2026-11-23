class_name ModulateFGCommand extends Command


@export var a_before:= 0.0

@export var a_after:= 0.0

@export var duration:= 1.0

@export var initial_delay:= 0.0

@export var final_delay:= 0.0



func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("before"):

		a_before = data.before

	if data.has("after"):

		a_after = data.after

	if data.has("duration"):

		duration = duration

	if data.has("final_delay"):

		final_delay = data.final_delay

	if data.has("initial_delay"):

		initial_delay = data.initial_delay

	UI.fg_rect.modulate.a = a_before

	if initial_delay > 0.0:

		Game.get_tree().create_timer(initial_delay).timeout.connect(_on_initial_delay_timeout)

	else:

		tween_rect()

	result = Result.PENDING

	return result




func tween_rect() -> void:

	var tween = Game.get_tree().create_tween()

	tween.finished.connect(_on_tween_finished)

	tween.tween_property(UI.fg_rect, "modulate:a", a_after, duration)



func _on_tween_finished() -> void:

	if final_delay > 0.0:

		Game.get_tree().create_timer(final_delay).timeout.connect(_on_final_delay_timeout)

	else:

		_on_final_delay_timeout()



func _on_initial_delay_timeout() -> void:

	tween_rect()



func _on_final_delay_timeout() -> void:

	result = Result.SUCCESS

	command_executed.emit()





	

static func run(_data:= {}) -> Command:

	var command = ModulateFGCommand.new()

	command.execute(_data)
	
	return command