class_name Inventory extends Resource


signal stack_index_updated(index: int, new_stack: ItemStack)

signal weapon_updated


@export var stacks: Array[ItemStack]

@export var size:= 9

@export var currency_stack:= CurrencyStack.new()

@export var weapon_stack: ItemStack

@export var tools: Array[Tool]




func resize(_size:= -1) -> void:

	if stacks.size() == _size:

		return

	if _size == -1:

		_size = size

	stacks.resize(_size)





func add_stack(stack: ItemStack) -> void:

	resize()

	if stack is CurrencyStack:

		currency_stack.merge_stack(stack)

		return

	var stacks_with_item = get_stacks_with(stack.item)

	if stacks_with_item.is_empty():

		var index = get_first_empty_index()

		if index != -1:

			set_stack_index(index, stack.duplicate(true))

			stack.set_count(0)

	else:

		for _stack in stacks_with_item:

			if _stack.can_merge_stack(stack):

				_stack.merge_stack(stack)

				if stack.is_empty():

					break




func add_item(item: Item, amount:= 1) -> void:

	resize()

	var stacks_with_item = get_stacks_with(item)

	var remaining = amount

	while remaining > 0 and not stacks_with_item.is_empty():

		var stack = stacks_with_item.pop_back()

		remaining = stack.remove_amount(remaining)



func add_tool(tool: Tool) -> void:

	if not tools.has(tool):

		tools.append(tool)

		Events.fire_script(PlayerAcquiredToolEvent, {"tool": tool}, true)



func remove_item(item: Item, amount:= 1) -> void:

	var stacks_with_item = get_stacks_with(item)

	var remaining = amount

	while remaining > 0 and not stacks_with_item.is_empty():

		var stack = stacks_with_item.pop_back()

		remaining = stack.remove_amount(remaining)









func clear() -> void:

	stacks.clear()




func is_empty() -> bool:

	for stack in stacks:

		if stack and not stack.is_empty():

			return false

	return true




func has_item(item: Item, amount:= 1) -> bool:

	if item is Tool:

		return tools.has(item)

	var stacks_with_item = get_stacks_with(item)

	var remaining = amount

	for stack in stacks_with_item:

		remaining -= stack.count

	return remaining <= 0







func get_item_stack(index: int) -> ItemStack:

	if index <= size - 1:

		if stacks.size() != size:

			resize()

		return stacks[index]

	return null



func get_first_empty_index() -> int:

	for i in range(stacks.size()):

		var stack = get_item_stack(i)

		if stack == null or stack.is_empty():

			return i

	return -1



func get_stacks_with(item: Item, count:= 1) -> Array:

	var _stacks = []

	for stack in stacks:

		if stack and stack.item == item and stack.count >= count:

			_stacks.append(stack)

	return _stacks



func set_stack_index(index: int, stack: ItemStack) -> void:

	if index <= size:

		if not stacks.size() - 1 > index:

			resize()

		stacks[index] = stack

		stack_index_updated.emit(index, stack)




func set_weapon_stack(item_stack: ItemStack) -> void:

	weapon_stack = item_stack

	weapon_updated.emit()









