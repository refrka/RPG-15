class_name ProjectileScene extends CharacterBody2D


@export var sprite: Sprite2D

@export var hitbox: Hitbox

@export var anim_player: AnimationPlayer



var disabled:= true

var trajectory:= Vector2.ZERO

var speed:= 1000.0




func _ready() -> void:

	anim_player.animation_finished.connect(_on_anim_finished)





func set_trajectory(_trajectory: Vector2) -> void:

	trajectory = _trajectory

	disabled = false





func _on_anim_finished(_anim_name: StringName) -> void:

	pass





func _physics_process(delta: float) -> void:

	if disabled:

		return

	velocity = trajectory * (speed * delta)

	move_and_slide()