class_name CombatComponent extends Component



var current_weapon_stack: ItemStack

var current_weapon_scene: WeaponScene


var current_weapon: Weapon:

	get:

		if not current_weapon_stack:

			return null

		return current_weapon_stack.item


var movement_component: MovementComponent

var animation_component: AnimationComponent

var cooldown_timer: SceneTreeTimer





func initialize(_entity: Entity) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	animation_component = entity.get_component(AnimationComponent)

	if entity.inventory and entity.inventory.weapon_stack:

		load_weapon(entity.inventory.weapon_stack)

		entity.inventory.weapon_updated.connect(_on_weapon_updated)




func load_weapon(weapon_stack: ItemStack) -> void:

	current_weapon_stack = weapon_stack

	if current_weapon_scene:

		current_weapon_scene.queue_free()

	if not current_weapon_stack:

		return

	current_weapon_scene = weapon_stack.item.weapon_scene.instantiate()

	current_weapon_scene.attack_finished.connect(_on_weapon_attack_finished)

	current_weapon_scene.projectile_requested.connect(_on_weapon_projectile_requested)

	current_weapon_scene.hitbox.hit_detected.connect(_on_weapon_hit_detected)

	entity.combat_root.add_child(current_weapon_scene)

	current_weapon_scene.hide()



func get_animation_name() -> String:

	return "%s/attack_%s" % [current_weapon_stack.item.item_id, entity.get_face_dir_string()]




func attack() -> void:

	if not is_instance_valid(current_weapon_scene):

		return

	if cooldown_timer != null and cooldown_timer.time_left > 0.0:

		return

	movement_component.move_locked = true

	current_weapon_scene.activate()

	var animation_name = get_animation_name()

	current_weapon_scene.anim_player.play(animation_name)




func start_attack_cooldown(duration: float) -> void:

	cooldown_timer = get_tree().create_timer(duration)

	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)




func get_projectile_scene() -> ProjectileScene:

	var projectile_scene: ProjectileScene = null

	if not current_weapon:

		return projectile_scene

	if current_weapon.default_ammunition:
		
		projectile_scene = current_weapon.default_ammunition.projectile_scene.instantiate()
		
	elif current_weapon_stack.item_data.ammunition_stack:
		
		projectile_scene = current_weapon_stack.item_data.ammunition_stack.item.projectile_scene.instantiate()

	projectile_scene.damage_package = DamagePackage.create(current_weapon.attack_entry, entity.face_dir, entity)

	return projectile_scene




func _on_weapon_attack_finished() -> void:

	if current_weapon.attack_cooldown > 0.0:

		start_attack_cooldown(current_weapon.attack_cooldown)

	movement_component.move_locked = false

	current_weapon_scene.deactivate()



func _on_weapon_projectile_requested() -> void:

	var projectile_scene = get_projectile_scene()

	if projectile_scene:

		projectile_scene.set_owning_entity(entity)

		Scenes.current_location.projectile_root.add_child(projectile_scene)

		projectile_scene.global_position = entity.global_position + entity.face_dir

		if projectile_scene.origin_at_center:

			projectile_scene.global_position += entity.center_marker.position

		match projectile_scene.projectile_type:

			ProjectileScene.ProjectileType.LINEAR:

				projectile_scene.set_trajectory(entity.face_dir)

			ProjectileScene.ProjectileType.ARC:

				var target_position = entity.face_dir * 30.0

				projectile_scene.set_arc(target_position, 30.0, 1.0)




func _on_cooldown_timer_timeout() -> void:

	cooldown_timer = null



func _on_weapon_updated() -> void:

	load_weapon(entity.inventory.weapon_stack)



func _on_weapon_hit_detected(hurtbox: Hurtbox) -> void:

	hurtbox.receive_damage_package(DamagePackage.create(current_weapon.attack_entry, entity.face_dir, entity))




func _unhandled_input(event: InputEvent) -> void:

	if not active:

		return

	if event.is_action_pressed("attack") and Inputs.is_action_allowed("attack"):

		attack()
