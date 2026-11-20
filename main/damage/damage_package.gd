class_name DamagePackage extends RefCounted



var source_entity: Entity

var source_dir: Vector2

var amount: int

var attack_entry: AttackEntry





static func create(_attack_entry: AttackEntry, _source_dir: Vector2, _source_entity: Entity = null) -> DamagePackage:

	var damage_package = DamagePackage.new()

	damage_package.attack_entry = _attack_entry

	damage_package.amount = _attack_entry.damage

	damage_package.source_entity = _source_entity

	damage_package.source_dir = _source_dir

	return damage_package