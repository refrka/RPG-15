class_name Player extends Character


@export var pickup_sensor: PickupSensor






func get_component(script: Script) -> Component:

	script = PlayerMovementComponent if script == MovementComponent else script

	return super(script)