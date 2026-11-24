class_name JournalQuestPanel extends MarginContainer

signal panel_selected


@onready var objective_row_scene:= preload("res://ui/objective_row.tscn")


@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat

@export var panel: PanelContainer

@export var arrow: TextureRect

@export var right_texture: Texture2D

@export var down_texture: Texture2D

@export var quest_info: MarginContainer

@export var title_label: Label

@export var objective_vbox: VBoxContainer




var selected:= false



func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	gui_input.connect(_on_gui_input)

	shrink()



func shrink() -> void:

	selected = false

	arrow.texture = right_texture

	quest_info.hide()



func expand() -> void:

	selected = true

	arrow.texture = down_texture

	quest_info.show()



func load_quest_data(quest_data: QuestData) -> void:

	title_label.text = quest_data.quest.quest_title

	if quest_data.state == Quest.QuestState.READY:

		title_label.text += " (READY)"

	for objective in quest_data.completed_objectives:

		var objective_row = objective_row_scene.instantiate()

		objective_vbox.add_child(objective_row)

		objective_row.load_objective(quest_data, objective)

		objective_row.set_objective_complete()

	for objective in quest_data.get_current_objectives():

		var objective_row = objective_row_scene.instantiate()

		objective_vbox.add_child(objective_row)

		objective_row.load_objective(quest_data, objective)





func _on_mouse_entered() -> void:

	if not selected:

		panel.add_theme_stylebox_override("panel", hovered_stylebox)


func _on_mouse_exited() -> void:

	if not selected:

		panel.add_theme_stylebox_override("panel", default_stylebox)


func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():

		panel_selected.emit()