class_name ObjectiveRow extends HBoxContainer


@export var objective_icon: TextureRect

@export var objective_label: Label


@export var icon_complete_texture: Texture2D

@export var icon_active_texture: Texture2D




func load_objective(_quest_data: QuestData, objective: QuestObjective) -> void:

	objective_label.text = objective.description



func set_objective_complete() -> void:

	objective_icon.texture = icon_complete_texture

	objective_label.modulate.a = 0.3