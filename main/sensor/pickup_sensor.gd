class_name PickupSensor extends Area2D





func _ready() -> void:

	body_entered.connect(_on_body_entered)



func _on_body_entered(body: PhysicsBody2D) -> void:

	if body is Pickup:

		body.float_to_entity(get_parent() as Entity)