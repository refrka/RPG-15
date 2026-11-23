class_name ContainerOverlay extends Overlay




@export var container_inventory_grid: InventoryGrid

@export var player_inventory_grid: InventoryGrid





func open() -> void:

	super()

	Inputs.disable_action("profile")




func close() -> void:

	super()

	Inputs.enable_action("profile")

	Cursor.cursor_slot.drop_slot()




func load_container_inventory(_inventory: Inventory) -> void:

	container_inventory_grid.load_inventory(_inventory)
	
	player_inventory_grid.load_inventory(Game.player.inventory)