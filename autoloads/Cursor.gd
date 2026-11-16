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

			[true, false]:

				if item_slot.can_accept_contents(cursor_slot):

					item_slot.set_stack(cursor_slot.item_stack)

					cursor_slot.held_slot.clear_slot()

					cursor_slot.drop_slot()

			[false, false]:

				if item_slot == cursor_slot.held_slot:

					cursor_slot.drop_slot()

				else:

					if cursor_slot.held_slot.can_accept_contents(item_slot) and item_slot.can_accept_contents(cursor_slot.held_slot):

						cursor_slot.held_slot.swap(item_slot)

						cursor_slot.copy_slot(item_slot)





func select_slot(slot: ItemSlot) -> void:

	if not multi_select_enabled:

		for _slot in selected_slots:

			_slot.set_selected_state(false)

	slot.set_selected_state(true)

	selected_slots.append(slot)



func deselect_slot(slot: ItemSlot) -> void:

	if selected_slots.has(slot):

		selected_slots.erase(slot)

		slot.set_selected_state(false)



func set_slot_hover_state(slot: ItemSlot, state: bool) -> void:

	slot.set_hovered_state(state)

	hovered_slot = null if state == false else slot