class_name CombatComponent extends Component



var current_weapon_stack: ItemStack

var current_weapon_scene: WeaponScene



var movement_component: MovementComponent

var animation_component: AnimationComponent





func initialize(_entity: Entity) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	animation_component = entity.get_component(AnimationComponent)




func load_weapon(weapon_stack: ItemStack) -> void:

	current_weapon_stack = weapon_stack

	if current_weapon_scene:

		current_weapon_scene.queue_free()

	current_weapon_scene = weapon_stack.item.weapon_scene.instantiate()

	entity.combat_root.add_child(current_weapon_scene)

	current_weapon_scene.hide()



func get_animation_name() -> String:

	return "%s/attack_%s" % [current_weapon_stack.item.item_id, movement_component.get_face_dir_string()]



func attack() -> void:

	current_weapon_scene.show()

	var animation_name = get_animation_name()

	current_weapon_scene.anim_player.play(animation_name)









func _unhandled_input(event: InputEvent) -> void:

	if not active:

		return

	if event.is_action_pressed("attack") and Inputs.is_action_allowed("attack"):

		attack()