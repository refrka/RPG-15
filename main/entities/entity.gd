class_name Entity extends PhysicsBody2D


signal deactivated



@export var entity_id: StringName

@export var authored_id: StringName

@export var speaker_texture: Texture2D

@export var stats:= EntityStats.new()

@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var combat_root: Node2D

@export var hurtbox: Hurtbox

@export var interaction_sensor: Sensor

@export var center_marker: Marker2D

@export var component_root: Node

@export var state_machine: StateMachine

@export var body_anim_player: AnimationPlayer

@export var inventory:= Inventory.new()

@export var death_loot_table: LootTable

@export var dialogue_library: DialogueLibrary



var components: Dictionary[Script, Component]



var active:= false

var initialized:= false




func initialize() -> bool:

	if initialized:

		return false

	inventory = inventory.duplicate(true)

	initialized = true

	state_machine.initialize(self)

	for component in component_root.get_children():

		components[component.get_script()] = component
		
		component.initialize(self)

	if hurtbox:

		hurtbox.initialize(self)

	if interaction_sensor:

		interaction_sensor.initialize(self)

	var animation_component = get_component(AnimationComponent)
	
	animation_component.death_animation_finished.connect(_on_death_animation_finished)

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

	state_machine.activate()

	components.values().map(func(c): c.activate())

	if hurtbox:

		hurtbox.activate()

	if interaction_sensor:

		interaction_sensor.activate()

	return true




func deactivate() -> bool:

	if not active:

		return false

	active = false

	state_machine.deactivate()

	components.values().map(func(c): c.deactivate())

	if hurtbox:

		hurtbox.deactivate()

	if interaction_sensor:

		interaction_sensor.deactivate()

	deactivated.emit()

	return true




func receive_damage_package(damage_package: DamagePackage) -> void:

	components.values().map(func(c): c._on_damage_package_received(damage_package))




func get_component(script: Script) -> Component:

	if components.has(script):

		return components[script]

	for component in component_root.get_children():

		if component.get_script() == script:

			return component

	return null



func get_interactable_component() -> InteractableComponent:

	for component in components.values():

		if component is InteractableComponent:

			return component

	return null





func is_alive() -> bool:

	var health_component = get_component(HealthComponent)

	if not health_component:

		return false

	return health_component.is_alive()





func die() -> void:
	
	if death_loot_table:

		var loot = death_loot_table.get_loot(randf())

		for stack in loot:

			var pickup = Pickup.create(stack)

			Scenes.current_location.add_pickup(pickup, global_position)

	hurtbox.deactivate()

	components.values().map(func(c): c._on_death())

	deactivate()




func consume(consumable: Consumable) -> void:

	var effects_component = get_component(EffectsComponent)

	for effect in consumable.effects_on_consume:

		effects_component.add_effect(effect)
		



func _on_death_animation_finished() -> void:

	var corpse_component = get_component(InteractableComponent)

	if corpse_component:

		pass

	else:

		body_anim_player.play("expire")

