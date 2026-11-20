class_name ContainerComponent extends InteractableComponent



@export var open_closed_frames:= Vector2i(0,1)

@export var loot_table: LootTable

@export var locked:= false


var opened_once:= false

var opened:= false



func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.body_sprite.frame = open_closed_frames.x





func start() -> void:

	if not opened_once:

		opened_once = true

		var loot = loot_table.get_loot(randf())

		entity.inventory.add_stack(loot)

	var overlay = UI.get_overlay(ContainerOverlay)

	UI.add_overlay(overlay)

	overlay.load_container_inventory(entity.inventory)

	entity.body_sprite.frame = open_closed_frames.y







func end() -> void:

	var overlay = UI.get_overlay(ContainerOverlay)

	UI.remove_overlay(overlay)

	entity.body_sprite.frame = open_closed_frames.x