class_name CraftingRecipe extends Resource


@export var recipe_id: StringName

@export var required_tool: Tool

@export var required_items: Dictionary[Item, int]

@export var product: Item