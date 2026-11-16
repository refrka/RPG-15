class_name Inventory extends Resource



@export var stacks: Array[ItemStack]

@export var size:= 9



@export var weapon_stack: ItemStack




func resize(_size:= -1) -> void:

	if _size == -1:

		_size = size

	stacks.resize(_size)




