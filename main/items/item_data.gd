class_name ItemData extends Resource


@export var durability:= 1.0



func matches(item_data: ItemData) -> bool:

	if durability != item_data.durability:

		return false

	return true