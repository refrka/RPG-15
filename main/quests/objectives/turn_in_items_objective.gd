class_name TurnInItemsObjective extends QuestObjective


@export var item: Item

@export var amount: int



func initialize() -> void:

	Events.subscribe(PlayerSubmittedItemEvent, _on_player_submitted_item)






func complete() -> void:

	Events.unsubscribe(PlayerSubmittedItemEvent, _on_player_submitted_item)

	super()





func _on_player_submitted_item(event: Event) -> void:

	if event.data.item == item and event.data.amount == amount:

		complete()