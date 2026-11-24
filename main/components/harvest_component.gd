class_name HarvestComponent extends InteractableComponent


@export var loot_table: LootTable

@export var duration:= 0.0

@export var die_on_harvest:= false

@export var free_on_harvest:= false

@export var harvest_state_frames:= Vector2i(0, 1)

@export var harvest_on_death_chance:= 0.0

var timer:= 0.0

var harvested:= false



func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.body_sprite.frame = harvest_state_frames.x



func start() -> void:

	if duration <= 0.0:

		complete()

	else:

		timer = duration

	




func complete() -> void:

	harvest()

	if die_on_harvest:

		entity.die()

	elif free_on_harvest:

		entity.deactivate()

		entity.queue_free()

	else:

		harvested = true

		entity.body_sprite.frame = harvest_state_frames.y

	completed.emit()





func harvest() -> void:

	if not loot_table:

		return

	var loot = loot_table.get_loot(randf())

	for stack in loot:

		var pickup = Pickup.create(stack)

		Scenes.current_location.add_pickup(pickup, entity.global_position)



func cancel() -> void:

	timer = 0.0

	super()




func can_interact() -> bool:

	return not harvested




func _on_death() -> void:

	if randf() < harvest_on_death_chance:

		harvest()



func _on_failed_interaction() -> void:

	entity.body_anim_player.play("harvestable/failed_harvest")







func _process(delta: float) -> void:

	if not active:

		return

	if timer > 0.0:

		timer -= delta

		if timer <= 0.0:

			complete()