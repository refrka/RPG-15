class_name SetQuestStageCommand extends Command


@export var quest: Quest

@export var quest_id: StringName

@export var index: int



func execute(_data:= {}) -> Result:

	super(_data)

	if _data.has("quest"):

		quest = _data.quest

	if _data.has("index"):

		index = _data.index

	Quests.set_quest_stage(quest, index)

	result = Result.SUCCESS

	return result