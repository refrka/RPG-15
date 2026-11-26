class_name DurationEffect extends Effect


signal expired

@export var duration:= 0.0

@export var tick_rate:= -1.0

var last_tick:= 0.0





func expire() -> void:

	expired.emit()




func tick(delta: float) -> void:

	super(delta)

	if tick_rate > 0.0:

		if time_alive - last_tick >= tick_rate:

			apply(target_entity)

			last_tick = time_alive

	if time_alive >= duration:

		expire()