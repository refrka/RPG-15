class_name CraftingComponent extends InteractableComponent



@export var recipes: Array[CraftingRecipe]





func start() -> void:

	var overlay = UI.get_overlay(CraftingOverlay)

	UI.add_overlay(overlay)

	overlay.closed.connect(_on_crafting_overlay_closed, CONNECT_ONE_SHOT)





func end() -> void:

	var overlay = UI.get_overlay(CraftingOverlay)

	UI.remove_overlay(overlay)




func _on_crafting_overlay_closed() -> void:

	complete()