class_name CraftingComponent extends InteractableComponent



@export var recipes: Array[CraftingRecipe]





func start() -> void:

	var overlay = UI.get_overlay(CraftingOverlay)

	UI.add_overlay(overlay)





func end() -> void:

	var overlay = UI.get_overlay(CraftingOverlay)

	UI.remove_overlay(overlay)