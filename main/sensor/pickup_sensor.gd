class_name PickupSensor extends Area2D





func _ready() -> void:

	body_entered.connect(_on_body_entered)

	body_exited.connect(_on_body_exited)



func _on_body_entered(body: PhysicsBody2D) -> void:

	if body is Pickup and not body.player_dropped:

		if body.pick_up_enabled:

			body.float_to_entity(get_parent() as Entity)

		else:

			body.pick_up_enabled_changed.connect(_on_pick_up_enabled_changed.bind(body), CONNECT_ONE_SHOT)



func _on_body_exited(body: PhysicsBody2D) -> void:

	if body is Pickup and body.player_dropped:

		body.player_dropped = false




func _on_pick_up_enabled_changed(state: bool, pickup: Pickup) -> void:

	if state == true and get_overlapping_bodies().has(pickup):

		pickup.float_to_entity(get_parent() as Entity)