class_name CraftingOverlay extends Overlay


@onready var ingredient_row_scene:= preload("res://ui/ingredient_row.tscn")


@export var ingredient_list_vbox: VBoxContainer

@export var product_item_slot: ItemSlot

@export var show_unknown_check_box: CheckBox

@export var recipe_list_vbox: VBoxContainer



var crafting_source: Entity

var crafting_component: CraftingComponent



var recipe_rows: Dictionary[CraftingRecipe, IngredientRow]



func load_crafting_source(source: Entity) -> void:

	crafting_source = source

	crafting_component = source.get_component(CraftingComponent)






