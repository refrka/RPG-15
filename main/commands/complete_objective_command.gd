class_name CompleteObjectiveCommand extends Command



@export var objective: QuestObjective





func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("quest_objective"):

		objective = data.quest_objective

	if objective:

		objective.complete()

	result = Result.SUCCESS

	return result