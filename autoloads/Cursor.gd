extends Node



var selected_slots: Array[ItemSlot]

var hovered_slot: ItemSlot

var cursor_slot: CursorSlot

var multi_select_enabled:= false







func handle_slot_input(item_slot: ItemSlot, event: InputEvent) -> void:

	if event.button_index == 1:

		match [item_slot.is_empty(), cursor_slot.is_empty()]:

			[false, true]:

				cursor_slot.copy_slot(item_slot)




func select_slot(slot: ItemSlot) -> void:

	pass





func set_slot_hover_state(slot: ItemSlot, state: bool) -> void:

	slot.set_hovered_state(state)

	hovered_slot = null if state == false else slot