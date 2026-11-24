class_name ProfileOverlay extends Overlay


@export var gold_count_label: Label

@export var inventory_grid: InventoryGrid

@export var weapon_slot: EquipmentSlot

@export var tool_rect_hbox: HBoxContainer

@export var tab_button_group: ButtonGroup

@export var quest_panel_vbox: VBoxContainer

@export var journal_tab: JournalTab




func _ready() -> void:

	weapon_slot.stack_updated.connect(_on_weapon_stack_updated)

	tab_button_group.pressed.connect(_on_tab_button_pressed)

	tab_button_group.get_buttons()[0].button_pressed = true

	tab_button_group.get_buttons()[0].pressed.emit()




func open() -> void:

	super()

	gold_count_label.text = str(Game.player.inventory.currency_stack.count)

	inventory_grid.load_inventory(Game.player.inventory)

	weapon_slot.set_stack(Game.player.inventory.weapon_stack)

	for tool_rect in tool_rect_hbox.get_children():

		tool_rect.update()

	journal_tab.load_quest_panels()





func close() -> void:

	super()

	Cursor.cursor_slot.drop_slot()






func load_quest_panels() -> void:

	pass








func _on_weapon_stack_updated() -> void:

	Game.player.inventory.set_weapon_stack(weapon_slot.item_stack)



func _on_tab_button_pressed(button: Button) -> void:

	for tab_button in tab_button_group.get_buttons():

		if tab_button == button:

			tab_button.tab.open()

		else:

			tab_button.tab.close()




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile") and Inputs.is_action_allowed("profile"):

		if not is_visible_in_tree():

			UI.add_overlay(self)

		else: 
			
			UI.remove_overlay(self)
