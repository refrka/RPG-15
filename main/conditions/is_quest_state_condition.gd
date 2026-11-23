class_name IsQuestStateCondition extends Condition





@export var quest: Quest

@export var quest_state: Quest.QuestState



func evaluate(_data:= {}) -> bool:

	if _data.has("quest"):

		quest = _data.quest

	if _data.has("quest_state"):

		quest_state = _data.quest_state

	return Quests.get_quest_state(quest) == quest_state