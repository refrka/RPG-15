class_name ItemTooltip extends MarginContainer


@export var item_label: Label


func _ready() -> void:

	deactivate()





func activate(item: Item) -> void:

	item_label.text = item.display_name

	show()



func deactivate() -> void:

	hide()






func _process(delta: float) -> void:

	if is_visible_in_tree():

		global_position = get_global_mouse_position() + Vector2(4.0, -20.0)