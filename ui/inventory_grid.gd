class_name InventoryGrid extends GridContainer


@onready var item_slot_scene:= preload("res://ui/item_slot.tscn")

var inventory: Inventory







func clear() -> void:

	for child in get_children():

		child.queue_free()




func load_inventory(_inventory: Inventory) -> void:

	clear()

	inventory = _inventory

	for i in range(inventory.size):

		var item_slot = item_slot_scene.instantiate()

		add_child(item_slot)

		var stack = inventory.get_item_stack(i)

		item_slot.set_stack(stack)

		item_slot.stack_updated.connect(_on_slot_stack_updated.bind(item_slot))




func _on_slot_stack_updated(item_slot: ItemSlot) -> void:

	var index = item_slot.get_index()

	inventory.set_stack_index(index, item_slot.item_stack)