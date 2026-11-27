class_name CraftingOverlay extends Overlay



@export var ingredient_list_vbox: VBoxContainer


var crafting_source: Entity

var crafting_component: CraftingComponent




func load_crafting_source(source: Entity) -> void:

	crafting_source = source

	crafting_component = source.get_component(CraftingComponent)