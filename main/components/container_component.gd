class_name ContainerComponent extends InteractableComponent



@export var open_closed_frames:= Vector2i(0,1)

@export var loot_table: LootTable

@export var locked:= false

@export var stay_open_when_empty:= false

@export var on_opened_command_set: CommandSet


var opened_once:= false

var opened:= false



func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.body_sprite.frame = open_closed_frames.x




func can_interact() -> bool:

	if opened:

		return false

	return not locked





func start() -> void:

	if not opened_once:

		opened_once = true

		if loot_table:

			var loot = loot_table.get_loot(randf())

			entity.inventory.add_stack(loot)

		if on_opened_command_set:

			on_opened_command_set.execute_all()

	opened = true

	var overlay = UI.get_overlay(ContainerOverlay)

	UI.add_overlay(overlay)

	overlay.load_container_inventory(entity.inventory)

	overlay.closed.connect(_on_container_overlay_closed, CONNECT_ONE_SHOT)

	entity.body_sprite.frame = open_closed_frames.y







func end() -> void:

	var overlay = UI.get_overlay(ContainerOverlay)

	if overlay.closed.is_connected(_on_container_overlay_closed):

		overlay.closed.disconnect(_on_container_overlay_closed)

	UI.remove_overlay(overlay)

	if stay_open_when_empty and entity.inventory.is_empty():

		entity.body_sprite.frame = open_closed_frames.y

	else:

		entity.body_sprite.frame = open_closed_frames.x

		opened = false






func _on_container_overlay_closed() -> void:

	complete()