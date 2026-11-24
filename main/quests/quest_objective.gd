class_name QuestObjective extends Resource


signal completed



@export var description: String

@export var optional:= false

@export var dialogue_option: DialogueQuestOption

@export var dialogue_target_ref: EntityRef




func initialize(quest_data: QuestData) -> void:

	if dialogue_option:

		dialogue_option.quest_data = quest_data

		dialogue_option.quest_objective = self



func complete() -> void:

	completed.emit()