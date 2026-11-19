class_name Overlay extends MarginContainer



signal closed


@export var pause:= false



func open() -> void:

	show()



func close() -> void:

	hide()

	closed.emit()