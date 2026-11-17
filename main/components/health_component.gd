class_name HealthComponent extends Component


signal health_changed(new_health: int)

signal health_restored(amount: int)

signal health_reduced

signal health_depleted


@export var make_corpse:= false

var current_health:= 1

var max_health:= 1




func initialize(_entity: Entity) -> void:

	super(_entity)

	max_health = entity.stats.base_health

	current_health = max_health




func set_current_health(new_health: int) -> void:

	current_health = new_health

	health_changed.emit(new_health)




func restore_health(amount: int) -> void:

	var new_health = min(max_health, current_health + amount)

	set_current_health(new_health)

	health_restored.emit(amount)



func reduce_health(amount: int) -> void:

	var new_health = max(0, current_health - amount)

	set_current_health(new_health)

	health_reduced.emit(amount)

	if not is_alive():

		health_depleted.emit()

		entity.die()



func is_alive() -> bool:

	return current_health > 0





func _on_damage_package_received(damage_package: DamagePackage) -> void:

	reduce_health(damage_package.amount)


