class_name Pickup extends CharacterBody2D


@export var sprite: Sprite2D

@export var anim_player: AnimationPlayer

var pick_up_enabled:= false

var stack: ItemStack

var pickup_target: Entity




func _ready() -> void:

	anim_player.animation_finished.connect(_on_animation_finished)

	anim_player.play("drop")




func float_to_entity(entity: Entity) -> void:

	pickup_target = entity




func pick_up() -> void:
	
	pickup_target.inventory.add_stack(stack)

	queue_free.call_deferred()




func update_visuals() -> void:

	sprite.texture = stack.item.icon_texture

	sprite.offset = stack.item.sprite_offset




func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == "drop":

		pick_up_enabled = true

		anim_player.play("float")




func _physics_process(_delta: float) -> void:

	if pickup_target and pick_up_enabled:

		var dist = sprite.global_position.distance_to(pickup_target.global_position)

		if dist < 6.0:

			pick_up()

		var dir = sprite.global_position.direction_to(pickup_target.global_position)

		velocity = dir * 150.0

		move_and_slide()






static func create(item_stack: ItemStack) -> Pickup:

	var pickup = load("res://main/items/pickup.tscn").instantiate()

	pickup.stack = item_stack

	pickup.update_visuals()

	return pickup