class_name Hurtbox extends Sensor


@export var hurt_cooldown:= 0.0

var hurt_timer:= 0.0



var damage_package_log: Array




func receive_damage_package(damage_package: DamagePackage) -> void:

	if hurt_timer > 0.0:

		return

	damage_package_log.append(damage_package)

	if entity:

		entity.receive_damage_package(damage_package)





func _process(delta: float) -> void:

	if not active:

		return

	if hurt_timer > 0.0:

		hurt_timer -= delta