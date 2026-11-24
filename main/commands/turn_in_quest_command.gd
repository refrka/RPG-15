class_name TurnInQuestCommand extends Command


var quest_data: QuestData


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("quest_data"):

		quest_data = data.quest_data

	print("quest data: ", quest_data)

	if quest_data:

		quest_data.set_state(Quest.QuestState.COMPLETE)

	result = Result.SUCCESS

	return result