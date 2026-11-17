class_name SetQuestStageCommand extends Command


@export var quest: Quest

@export var index: int



func execute(_data:= {}) -> Result:

	super(_data)

	Quests.set_quest_stage(quest, index)

	result = Result.SUCCESS

	return result