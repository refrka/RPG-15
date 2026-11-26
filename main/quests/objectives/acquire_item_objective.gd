class_name AcquireItemObjective extends QuestObjective


@export var item: Item


func initialize(quest_data: QuestData) -> void:

	super(quest_data)

	Events.subscribe(PlayerAcquiredItemEvent, _on_player_acquired_item)




func is_complete() -> bool:

	print("checking if this is complete: ", description)

	print("complete: ", Game.player.inventory.has_item(item))

	return Game.player.inventory.has_item(item)



func _on_player_acquired_item(event: Event) -> void:

	if event.data.has("item") and event.data.item == item:

		Events.unsubscribe(PlayerAcquiredItemEvent, _on_player_acquired_item)

		complete()