class_name PlayerHasItemCondition extends Condition



@export var item: Item

@export var amount: int



func evaluate(_data:= {}) -> bool:

	if _data.has("item"):

		item = _data.item

	if _data.has("amount"):

		amount = _data.amount

	return Game.player.inventory.has_item(item, amount)