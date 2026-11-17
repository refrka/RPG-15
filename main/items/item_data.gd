class_name ItemData extends Resource


@export var durability:= 1.0

@export var ammunition_stack: ItemStack



func matches(item_data: ItemData) -> bool:

	if durability != item_data.durability:

		return false

	if ammunition_stack or item_data.ammunition_stack:

		return false

	return true