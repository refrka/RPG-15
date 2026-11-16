class_name ItemStack extends Resource


signal count_updated

signal item_updated


@export var item: Item

@export var count:= -1

@export var item_data: ItemData








func add_amount(amount: int) -> int:

	var space = item.max_stack - count

	var remaining = amount

	var new_count = count

	if space >= remaining:

		new_count += remaining

		remaining = 0

	else:

		new_count = item.max_stack

		remaining -= space

	set_count(new_count)

	return remaining



func remove_amount(amount: int) -> int:

	var remaining = amount

	var new_count = count

	if count >= remaining:

		new_count -= remaining

		remaining = 0

	else:

		new_count = 0

		remaining -= count

	set_count(new_count)

	return remaining



func set_item(_item: Item, _item_data: ItemData = null) -> void:

	item = _item

	item_data = _item_data

	if item is Equipment and item_data == null:

		item_data = ItemData.new()

	item_updated.emit()



func set_count(_count: int) -> void:

	count = _count

	count_updated.emit()




func merge_stack(stack: ItemStack) -> void:

	var remaining = add_amount(stack.count)

	stack.set_count(remaining)





func is_empty() -> bool:

	return not item or count <= 0




func can_merge_stack(stack: ItemStack) -> bool:

	if stack.item != item:

		return false

	if item_data:

		if not stack.item_data:

			return false

		if not item_data.matches(stack.item_data):

			return false

	return true




static func create(_item: Item, _count:= 1, _item_data: ItemData = null) -> ItemStack:

	var stack = ItemStack.new()

	stack.item = _item

	stack.count = _count

	stack.item_data = _item_data

	return stack