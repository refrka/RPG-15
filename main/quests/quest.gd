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







func get_stage(index: int) -> QuestStage:

	return null if stages.size() - 1 < index else stages[index]