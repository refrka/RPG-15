extends Node



var active_quests: Array[QuestData]




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS






func get_root_options(source_entity: Entity) -> Array:

	var root_options = []

	return root_options



func get_quest_state(quest: Quest) -> Quest.QuestState:

	var quest_data = get_quest_data(quest)

	if quest_data:

		return quest_data.state

	return Quest.QuestState.UNKNOWN



func get_quest_data(quest: Quest) -> QuestData:

	for quest_data in active_quests:

		if quest_data.quest == quest:

			return quest_data

	return null






func set_quest_stage(quest: Quest, index: int) -> void:

	var quest_data = get_quest_data(quest)

	if not quest_data:

		quest_data = QuestData.create(quest)

		quest_data.state_changed.connect(_on_quest_state_changed)

	quest_data.set_stage_index(index)

	var stage = quest.get_stage(index)

	stage.objective_completed.connect(_on_stage_objective_completed.bind(quest_data))









func _on_stage_objective_completed(objective: QuestObjective, quest_data: QuestData) -> void:

	quest_data.completed_objectives.append(objective)

	var stage = quest_data.get_stage()

	var complete:= true

	for _objective in stage.objectives:

		if not quest_data.completed_objectives.has(_objective):

			complete = false

			break

	if complete:

		_on_quest_stage_completed(quest_data)





func _on_quest_stage_completed(quest_data: QuestData) -> void:

	var next_stage_index = quest_data.stage_index + 1

	var next_stage = quest_data.get_stage(next_stage_index)

	if next_stage:

		quest_data.set_stage_index(next_stage_index)

	else:

		quest_data.set_state(Quest.QuestState.COMPLETE)




func _on_quest_state_changed(new_state: Quest.QuestState) -> void:

	match new_state:

		Quest.QuestState.COMPLETE:

			pass