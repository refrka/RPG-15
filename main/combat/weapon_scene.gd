class_name WeaponScene extends Node2D



@export var sprite: Sprite2D

@export var hitbox: Hitbox

@export var anim_player: AnimationPlayer





func _ready() -> void:

	anim_player.animation_finished.connect(_on_anim_finished)



func _on_anim_finished(_anim_name: String) -> void:

	hide()