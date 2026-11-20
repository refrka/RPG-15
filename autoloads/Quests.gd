extends Node



var active_quests: Array[QuestData]

var quest_registry: Dictionary[StringName, Quest]



func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	load_quest_registry()




func load_quest_registry() -> void:

	var dir = "res://main/quests/resources/"

	for dir_name in ResourceLoader.list_directory(dir):

		if dir_name.ends_with(".tres"):

			var quest = load(dir + dir_name) as Quest

			quest_registry[quest.quest_id] = quest





func get_root_options(source_entity: Entity) -> Array:

	var root_options = []

	for quest_data in active_quests:

		var current_objectives = quest_data.get_current_objectives()

		for objective in current_objectives:

			if not objective.dialogue_target_ref or not objective.dialogue_option:

				continue

			if objective.dialogue_target_ref.matches(source_entity) and objective.dialogue_option:

				if not objective.dialogue_option.passes_conditions():

					continue

				root_options.append(objective.dialogue_option)

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



func get_quest(quest_id: StringName) -> Quest:

	if quest_registry.has(quest_id):

		return quest_registry[quest_id]

	return null




func get_quest_objectives(quest_data: QuestData) -> Array:

	var objectives = []

	var stage = quest_data.get_stage()

	for _objective in stage.objectives:

		if not quest_data.completed_objectives.has(_objective):

			objectives.append(_objective)

	return objectives




func set_quest_stage(quest: Quest, index: int) -> void:

	var quest_data = get_quest_data(quest)

	if not quest_data:

		quest_data = QuestData.create(quest)

		quest_data.state_changed.connect(_on_quest_state_changed)

		active_quests.append(quest_data)

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