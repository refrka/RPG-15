class_name Sensor extends Area2D


signal entity_entered(_entity: Entity)

signal entity_exited(_entity: Entity)

signal sensor_entered(sensor: Sensor)

signal sensor_exited(sensor: Sensor)



var active:= false

var entity: Entity



var entities: Array

var sensors: Array









func initialize(_entity: Entity = null) -> void:

	entity = _entity





func connect_signals() -> void:

	body_entered.connect(_on_body_entered)

	body_exited.connect(_on_body_exited)

	area_entered.connect(_on_area_entered)

	area_exited.connect(_on_area_exited)




func disconnect_signals() -> void:

	body_entered.disconnect(_on_body_entered)

	body_exited.disconnect(_on_body_exited)

	area_entered.disconnect(_on_area_entered)

	area_exited.disconnect(_on_area_exited)









func activate() -> void:

	if active:

		return

	active = true

	connect_signals()

	for area in get_overlapping_areas():

		_on_area_entered(area)

	for body in get_overlapping_bodies():

		_on_body_entered(body)




func deactivate() -> void:

	if not active:

		return

	active = false

	disconnect_signals()

	entities.clear()

	sensors.clear()










func _on_body_entered(body: Variant) -> void:

	if not active or body == entity or body is TileMap:

		return

	if body is Entity and not entities.has(body):

		entities.append(body)

		body.deactivated.connect(_on_entity_deactivated.bind(body), CONNECT_ONE_SHOT)

		entity_entered.emit(body)


	

func _on_body_exited(body: Variant) -> void:

	if not active or body is TileMap:

		return

	if entities.has(body):

		entities.erase(body)

		if body.deactivated.is_connected(_on_entity_deactivated):

			body.deactivated.disconnect(_on_entity_deactivated)

		entity_exited.emit(body)




func _on_area_entered(area: Area2D) -> void:

	if not active:

		return

	if area is Sensor and not sensors.has(area) and area.entity != entity and area.active:

		sensors.append(area)

		sensor_entered.emit(area)

	


func _on_area_exited(area: Area2D) -> void:

	if not active:

		return

	if sensors.has(area):

		sensors.erase(area)

		sensor_exited.emit(area)





func _on_entity_deactivated(_entity: Entity) -> void:

	if entities.has(_entity):

		entities.erase(_entity)