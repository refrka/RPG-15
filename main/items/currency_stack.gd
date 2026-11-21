class_name CurrencyStack extends ItemStack




func _init() -> void:

	item = load("res://main/items/valuables/coin.tres")




static func create(_item: Item, _count:= 1, _item_data: ItemData = null) -> ItemStack:

	var stack = CurrencyStack.new()

	stack.item = _item

	stack.count = _count

	stack.item_data = _item_data

	return stack