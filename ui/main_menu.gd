class_name MainMenu extends Overlay



@export var new_save_container: MarginContainer

@export var load_save_container: MarginContainer

@export var name_line_edit: LineEdit

@export var start_button: Button

@export var current_save_label: Label

@export var load_button: Button

@export var delete_button: Button




func _ready() -> void:

	start_button.pressed.connect(_on_start_button_pressed)

	load_button.pressed.connect(_on_load_button_pressed)

	delete_button.pressed.connect(_on_delete_button_pressed)






func update_load_save_container() -> void:

	current_save_label.text = "\"%s\"" % Saves.last_save_dict["save_name"]





func _on_start_button_pressed() -> void:

	Saves.create_save(name_line_edit.text)



func _on_load_button_pressed() -> void:

	Game.load_save()




func _on_delete_button_pressed() -> void:

	Saves.delete_save()