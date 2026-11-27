class_name PickupSensor extends Area2D





func _ready() -> void:

	body_entered.connect(_on_body_entered)

	body_exited.connect(_on_body_exited)



func _on_body_entered(body: PhysicsBody2D) -> void:

	if body is Pickup and not body.player_dropped and body.pick_up_enabled:

		body.float_to_entity(get_parent() as Entity)



func _on_body_exited(body: PhysicsBody2D) -> void:

	if body is Pickup and body.player_dropped:

		body.player_dropped = false