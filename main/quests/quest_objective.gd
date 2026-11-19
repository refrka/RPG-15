class_name QuestObjective extends Resource


signal completed




@export var optional:= false

@export var dialogue_node: DialogueNode

@export var dialogue_target_ref: EntityRef




func initialize() -> void:

	pass



func complete() -> void:

	completed.emit()