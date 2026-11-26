class_name TurretComponent extends Component

@export var attack_entry: AttackEntry

@export var projectile_scene: PackedScene

@export var ray_root: Node2D

@export var cooldown_duration:= 1.0

var timer:= 0.0

var target_rays: Array



var animation_component: AnimationComponent



func initialize(_entity: Entity) -> void:

	super(_entity)

	target_rays = ray_root.get_children()

	for ray in target_rays:

		ray.add_exception(entity.hurtbox)

	entity.face_dir_updated.connect(_on_face_dir_updated)

	animation_component = entity.get_component(AnimationComponent)

	entity.body_anim_player.animation_finished.connect(_on_animation_finished)





func start_projectile() -> void:

	animation_component.play_body_animation("%s/fire_projectile" % entity.entity_id)




func fire_projectile() -> void:

	var projectile = projectile_scene.instantiate() as ProjectileScene

	projectile.set_owning_entity(entity)

	Scenes.current_location.projectile_root.add_child(projectile)

	projectile.global_position = entity.global_position + entity.face_dir

	if projectile.origin_at_center:

		projectile.global_position += entity.center_marker.position

	projectile.set_trajectory(entity.face_dir)

	projectile.damage_package = DamagePackage.create(attack_entry, projectile.trajectory, entity)

	timer = cooldown_duration

	await get_tree().create_timer(0.2).timeout

	animation_component.play_body_animation("RESET")







func is_target_in_sight() -> bool:

	for ray in target_rays:

		if ray.is_colliding():

			var collider = ray.get_collider()

			if collider is Hurtbox and collider.entity.entity_id == entity.entity_id:

				return false

			return true

	return false



func _on_face_dir_updated(dir: Vector2) -> void:

	ray_root.rotation = dir.angle()



func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name.ends_with("fire_projectile"):

		fire_projectile()





func _process(delta: float) -> void:

	if not active:

		return

	if timer <= 0.0 and is_target_in_sight():

		start_projectile()

	else:

		timer -= delta



