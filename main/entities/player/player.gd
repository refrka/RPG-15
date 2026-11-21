class_name Player extends Character


@export var pickup_sensor: PickupSensor



func initialize() -> bool:

	if not super():

		return false

	Events.fire_script(PlayerInitializedEvent)

	return true



func get_component(script: Script) -> Component:

	script = PlayerMovementComponent if script == MovementComponent else script

	

	return super(script)