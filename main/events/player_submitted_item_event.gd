class_name PlayerSubmittedItemEvent extends GameEvent


@export var item: Item

@export var amount:= 0



func fire(_data:={}) -> void:

	super(_data)

	if data.has("item"):

		item = data.item

	if data.has("amount"):

		amount = data.amount




func get_notice_message() -> String:

	return "Items removed from inventory: %s (%s)" % [item.item_id, amount]