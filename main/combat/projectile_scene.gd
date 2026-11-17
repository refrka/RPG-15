class_name ProjectileScene extends CharacterBody2D


signal target_reached

signal target_hit(target: Entity)


enum ProjectileType {

	LINEAR,

	ARC

}


@export var projectile_type: ProjectileType

@export var sprite: Sprite2D

@export var hitbox: Hitbox

@export var anim_player: AnimationPlayer

@export var on_screen_notifier: VisibleOnScreenNotifier2D

@export var timer: Timer



var owning_entity: Entity

var disabled:= true

var trajectory:= Vector2.ZERO




func _ready() -> void:

	on_screen_notifier.screen_exited.connect(_on_screen_exited)





func move_in_arc(start_pos: Vector2, end_pos: Vector2, arc_height: float, duration: float) -> void:

	var tween = create_tween()

	tween.tween_method(

		func(t: float):

			var linear_pos = start_pos.lerp(end_pos, t)

			var height_offset = sin(t * PI) * arc_height

			sprite.position = linear_pos - Vector2(0, height_offset),

		0.0, 1.0, duration

	)

	tween.finished.connect(_on_arc_tween_finished)



	

func set_arc(end_pos: Vector2, arc_height: float, duration: float) -> void:

	move_in_arc(Vector2.ZERO, end_pos, arc_height, duration)





func set_trajectory(_trajectory: Vector2) -> void:

	trajectory = _trajectory

	rotation = trajectory.angle()

	disabled = false



func _on_screen_exited() -> void:

	if not timer.time_left == 0.0:

		return

	timer.start()




func _on_arc_tween_finished() -> void:

	target_reached.emit()

	queue_free()




func _physics_process(delta: float) -> void:

	if trajectory != Vector2.ZERO and not disabled:

		velocity = trajectory * 5000.0 * delta

		move_and_slide()