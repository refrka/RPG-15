class_name QuestEventObjective extends QuestObjective


@export var event: Event




func initialize(quest_data: QuestData) -> void:

	super(quest_data)

	if event:

		Events.subscribe(event.get_script(), _on_event)



func _on_event(_event: Event) -> void:

	if event.data == _event.data:

		Events.unsubscribe(event.get_script(), _on_event)

		complete()