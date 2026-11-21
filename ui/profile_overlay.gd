class_name ProfileOverlay extends Overlay


@export var gold_count_label: Label

@export var inventory_grid: InventoryGrid

@export var weapon_slot: EquipmentSlot





func _ready() -> void:

	weapon_slot.stack_updated.connect(_on_weapon_stack_updated)





func open() -> void:

	super()

	gold_count_label.text = str(Game.player.inventory.currency_stack.count)

	inventory_grid.load_inventory(Game.player.inventory)

	weapon_slot.set_stack(Game.player.inventory.weapon_stack)





func _on_weapon_stack_updated() -> void:

	Game.player.inventory.set_weapon_stack(weapon_slot.item_stack)





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile") and Inputs.is_action_allowed("profile"):

		if not is_visible_in_tree():

			UI.add_overlay(self)

		else: 
			
			UI.remove_overlay(self)
