class_name ProjectileScene extends CharacterBody2D


signal target_reached

signal target_hit(target: Entity)


enum ProjectileType {

	LINEAR,

	ARC

}


@export var projectile_type: ProjectileType

@export var sprite: Sprite2D

@export var collision: CollisionShape2D

@export var hitbox: Hitbox

@export var anim_player: AnimationPlayer

@export var origin_at_center:= false

@export var on_screen_notifier: VisibleOnScreenNotifier2D

@export var timer: Timer

@export var speed:= 5000.0

@export var ignore_entity_ref:= false



var owning_entity: Entity

var disabled:= true

var trajectory:= Vector2.ZERO

var damage_package: DamagePackage




func _ready() -> void:

	on_screen_notifier.screen_exited.connect(_on_screen_exited)

	hitbox.hit_detected.connect(_on_hitbox_hit_detected)

	hitbox.initialize()

	hitbox.activate()



func set_projectile_rotation(angle: float) -> void:

	sprite.rotation = angle

	hitbox.rotation = angle

	collision.rotation = angle




func move_in_arc(start_pos: Vector2, end_pos: Vector2, arc_height: float, duration: float) -> void:

	var tween = create_tween()

	tween.tween_method(

		func(t: float):

			var linear_pos = start_pos.lerp(end_pos, t)

			var height_offset = sin(t * PI) * arc_height

			var target_pos = linear_pos - Vector2(0, height_offset)

			# global_position = linear_pos + owning_entity.global_position

			sprite.position = target_pos

			hitbox.position = target_pos,

		0.0, 1.0, duration

	)

	tween.finished.connect(_on_arc_tween_finished)



	

func set_arc(end_pos: Vector2, arc_height: float, duration: float) -> void:

	move_in_arc(owning_entity.center_marker.position, end_pos, arc_height, duration)





func set_trajectory(_trajectory: Vector2) -> void:

	trajectory = _trajectory

	rotation = trajectory.angle()

	disabled = false



func set_owning_entity(_owning_entity: Entity) -> void:

	owning_entity = _owning_entity

	hitbox.hurtbox_blacklist.append(owning_entity.hurtbox)

	if ignore_entity_ref:

		var ref = EntityRef.create(owning_entity)

		hitbox.entity_ref_blacklist.append(ref)



func _on_screen_exited() -> void:

	if not timer.time_left == 0.0:

		return

	timer.start()




func _on_arc_tween_finished() -> void:

	target_reached.emit()

	queue_free()




func _on_hitbox_hit_detected(hurtbox: Hurtbox) -> void:

	hurtbox.receive_damage_package(damage_package)

	reparent.call_deferred(hurtbox.entity)

	trajectory = Vector2.ZERO

	hitbox.deactivate()

	timer.start()





func _physics_process(delta: float) -> void:

	if trajectory != Vector2.ZERO and not disabled:

		velocity = trajectory * speed * delta

		move_and_slide()

		var last_collision = get_last_slide_collision()

		if last_collision != null:

			var collider = last_collision.get_collider()

			if not collider is TileMapLayer:

				reparent.call_deferred(collider)

			trajectory = Vector2.ZERO

			timer.start()



