class_name JournalQuestPanel extends MarginContainer



@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat

@export var panel: PanelContainer

@export var arrow: TextureRect

@export var right_texture: Texture2D

@export var down_texture: Texture2D


var selected:= false


func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)





func _on_mouse_entered() -> void:

	if not selected:

		panel.add_theme_stylebox_override("panel", hovered_stylebox)


func _on_mouse_exited() -> void:

	if not selected:

		panel.add_theme_stylebox_override("panel", default_stylebox)