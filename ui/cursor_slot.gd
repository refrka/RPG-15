class_name CursorSlot extends ItemSlot


var held_slot: ItemSlot



func _ready() -> void:

	super()

	Cursor.cursor_slot = self




func copy_slot(slot: ItemSlot) -> void:

	held_slot = slot

	set_stack(held_slot.item_stack)

	Cursor.select_slot(slot)



func drop_slot() -> void:

	Cursor.deselect_slot(held_slot)

	held_slot = null

	clear_slot()




func _process(_delta: float) -> void:

	if not is_empty():

		global_position = get_global_mouse_position()