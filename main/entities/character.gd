class_name Character extends Entity


@export var vision_sensor: VisionSensor

@export var nav_agent: NavigationAgent2D



func initialize() -> bool:

	if not super():

		return false

	vision_sensor.initialize(self)

	return true




func activate() -> bool:

	if not super():

		return false

	vision_sensor.activate()

	return true




func deactivate() -> bool:

	if not super():

		return false

	vision_sensor.deactivate()

	return true



