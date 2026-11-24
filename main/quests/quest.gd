class_name Quest extends Resource



enum QuestState {

	UNKNOWN,

	AVAILABLE,

	ACTIVE,

	READY,

	COMPLETE,

	FAILED,

}

@export var quest_id: StringName

@export var quest_title: String

@export var stages: Array[QuestStage]

@export var auto_complete:= true

@export var turn_in_entity_ref: EntityRef





func get_stage(index: int) -> QuestStage:

	return null if stages.size() - 1 < index else stages[index]



func is_valid() -> bool:

	if stages.is_empty():

		return false

	return true