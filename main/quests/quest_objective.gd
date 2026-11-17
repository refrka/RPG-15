class_name QuestObjective extends Resource


signal completed




@export var optional:= false





func initialize() -> void:

	pass



func complete() -> void:

	completed.emit()