class_name Inventory extends Resource


signal stack_index_updated(index: int, new_stack: ItemStack)


@export var stacks: Array[ItemStack]

@export var size:= 9

@export var weapon_stack: ItemStack




func resize(_size:= -1) -> void:

	if _size == -1:

		_size = size

	stacks.resize(_size)




func clear() -> void:

	stacks.clear()




func is_empty() -> bool:

	for stack in stacks:

		if stack and not stack.is_empty():

			return false

	return true




func set_stack_index(index: int, stack: ItemStack) -> void:

	if index <= size:

		if not stacks.size() - 1 > index:

			resize()

		stacks[index] = stack

		stack_index_updated.emit(index, stack)