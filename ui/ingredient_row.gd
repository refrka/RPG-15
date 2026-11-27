class_name IngredientRow extends HBoxContainer


@export var texture_rect: TextureRect

@export var label: Label




func set_ingredient(item: Item, amount: int) -> void:

	texture_rect.texture = item.icon_texture

	label.text = "x%s" % amount