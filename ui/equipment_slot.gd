class_name EquipmentSlot extends ItemSlot





func can_accept_contents(slot: ItemSlot) -> bool:

	if not super(slot):

		return false

	if not slot.item_stack.item is Equipment:

		return false

	return true