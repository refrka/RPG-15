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

	if _data.has("quest_id"):

		quest_id = _data.quest_id

	if not quest:

		quest = Quests.get_quest(quest_id)

	Quests.set_quest_stage(quest, index)

	result = Result.SUCCESS

	return result