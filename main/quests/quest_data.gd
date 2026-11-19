class_name QuestData extends RefCounted


signal state_changed(new_state: Quest.QuestState)

signal stage_completed


var quest: Quest

var state: Quest.QuestState

var stage_index:= -1

var completed_objectives: Array[QuestObjective]






func initialize_stage(index: int) -> void:

	var stage = quest.get_stage(index)

	if stage:

		stage.initialize()





func set_stage_index(index: int) -> void:

	if stage_index == -1 and index == 0:

		set_state(Quest.QuestState.ACTIVE)

	stage_index = index

	initialize_stage(index)




func set_state(_state: Quest.QuestState) -> void:

	state = _state



func get_stage(index:= -1) -> QuestStage:

	if index == -1:

		index = stage_index

	return quest.get_stage(index)



func get_current_objectives() -> Array:

	var current_objectives = []

	var stage = get_stage()

	for objective in stage.objectives:

		if not completed_objectives.has(objective):

			current_objectives.append(objective)

	return current_objectives




static func create(_quest: Quest) -> QuestData:

	var quest_data = QuestData.new()

	quest_data.quest = _quest

	return quest_data