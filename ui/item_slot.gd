class_name ItemSlot extends MarginContainer


signal stack_updated


@export var default_stylebox: StyleBox

@export var hovered_empty_stylebox: StyleBox

@export var selected_stylebox: StyleBox

@export var panel: PanelContainer

@export var texture_rect: TextureRect

@export var count_label: Label




@export var item_stack: ItemStack






var hovered:= false

var selected:= false


func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	gui_input.connect(_on_gui_input)

	if item_stack != null:

		set_stack(item_stack.duplicate(true))

		if item_stack.item is Equipment:

			item_stack.item_data = ItemData.new()

	update_visuals()






func clear_slot() -> void:

	set_stack(null)




func set_stack(_item_stack: ItemStack) -> void:

	item_stack = _item_stack

	update_visuals()

	stack_updated.emit()




func is_empty() -> bool:

	return not item_stack or item_stack.is_empty()




func can_accept_contents(slot: ItemSlot) -> bool:

	return true




func update_visuals() -> void:

	var stylebox = default_stylebox

	if hovered:

		if is_empty():

			stylebox = hovered_empty_stylebox

	if selected:

		stylebox = selected_stylebox

	panel.add_theme_stylebox_override("panel", stylebox)

	if item_stack:

		texture_rect.texture = item_stack.item.icon_texture

		count_label.text = "" if item_stack.count <= 1 else str(item_stack.count)

	else:

		texture_rect.texture = null

		count_label.text = ""



func swap(target_slot: ItemSlot) -> void:

	var temp_stack = target_slot.item_stack

	target_slot.set_stack(item_stack)

	set_stack(temp_stack)




func set_selected_state(state: bool) -> void:

	selected = state

	update_visuals()



func set_hovered_state(state: bool) -> void:

	hovered = state

	update_visuals()




func _on_mouse_entered() -> void:

	Cursor.set_slot_hover_state(self, true)



func _on_mouse_exited() -> void:

	Cursor.set_slot_hover_state(self, false)



func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		Cursor.handle_slot_input(self, event)
