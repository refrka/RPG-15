class_name RemoveItemsFromPlayerInventoryCommand extends Command


@export var item: Item

@export var amount: int




func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("item"):

		item = data.item

	if data.has("amount"):

		amount = data.amount

	data["item"] = item

	data["amount"] = amount

	Game.player.inventory.remove_item(item, amount)

	result = Result.SUCCESS

	return result