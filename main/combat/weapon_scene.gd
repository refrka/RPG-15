class_name WeaponScene extends Node2D

signal attack_finished

signal projectile_requested

@export var sprite: Sprite2D

@export var hitbox: Hitbox

@export var anim_player: AnimationPlayer





func _ready() -> void:

	anim_player.animation_finished.connect(_on_anim_finished)




func fire_projectile() -> void:

	projectile_requested.emit()




func _on_anim_finished(_anim_name: String) -> void:

	attack_finished.emit()

	hide()