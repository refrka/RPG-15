class_name Entity extends PhysicsBody2D



@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var combat_root: Node2D

@export var center_marker: Marker2D

@export var component_root: Node

@export var state_machine: StateMachine

@export var inventory: Inventory


var components: Dictionary[Script, Component]



var active:= false

var initialized:= false




func initialize() -> bool:

	if initialized:

		return false

	initialized = true

	for component in component_root.get_children():

		components[component.get_script()] = component
		
		component.initialize(self)

	state_machine.initialize(self)

	return true




func reset() -> void:

	if active:

		deactivate()

	initialized = false

	components.values().map(func(c): c.reset())

	components.clear()

	state_machine.reset()





func activate() -> bool:

	if active:

		return false

	active = true

	components.values().map(func(c): c.activate())

	state_machine.activate()

	return true




func deactivate() -> bool:

	if not active:

		return false

	active = false

	components.values().map(func(c): c.deactivate())

	state_machine.deactivate()

	return true






func get_component(script: Script) -> Component:

	if components.has(script):

		return components[script]

	return null