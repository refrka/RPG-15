class_name Pickup extends CharacterBody2D

signal pick_up_enabled_changed(state: bool)

@export var sprite: Sprite2D

@export var shadow: Sprite2D

@export var anim_player: AnimationPlayer

@export var stack: ItemStack

var pick_up_enabled:= false

var pickup_target: Entity

var player_dropped:= false




func _ready() -> void:

	anim_player.animation_finished.connect(_on_animation_finished)

	anim_player.play("drop")

	shadow.hide()




func float_to_entity(entity: Entity) -> void:

	if not anim_player.current_animation == "drop":

		pick_up_enabled = true

		pick_up_enabled_changed.emit(true)

	pickup_target = entity




func pick_up() -> void:
	
	pickup_target.inventory.add_stack(stack)

	if stack.is_empty():

		queue_free.call_deferred()

	else:

		pick_up_enabled = false

		pick_up_enabled_changed.emit(false)

		pickup_target = null




func update_visuals() -> void:

	sprite.texture = stack.item.icon_texture

	sprite.offset = stack.item.sprite_offset




func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == "drop":

		shadow.show()

		anim_player.play("float")

		await get_tree().create_timer(0.3).timeout

		pick_up_enabled = true

		pick_up_enabled_changed.emit(true)




func _physics_process(_delta: float) -> void:

	if pickup_target and pick_up_enabled:

		var dist = sprite.global_position.distance_to(pickup_target.center_marker.global_position)

		if dist < 8.0:

			pick_up.call_deferred()

		var dir = sprite.global_position.direction_to(pickup_target.center_marker.global_position)

		velocity = dir * 150.0

		move_and_slide()






static func create(item_stack: ItemStack) -> Pickup:

	var pickup = load("res://main/items/pickup.tscn").instantiate()

	pickup.stack = item_stack

	pickup.update_visuals()

	return pickup