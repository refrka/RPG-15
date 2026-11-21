class_name DurationEffect extends Effect

signal expired

@export var duration:= 0.0




func tick(delta: float) -> void:

	super(delta)

	if time_alive >= duration:

		expired.emit()