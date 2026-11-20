class_name Component extends Node








var active:= false

var entity: Entity



func initialize(_entity: Entity) -> void:

	entity = _entity



func reset() -> void:

	entity = null



func activate() -> void:

	active = true



func deactivate() -> void:

	active = false



func _on_damage_package_received(damage_package: DamagePackage) -> void:

	pass



func _on_death() -> void:

	pass