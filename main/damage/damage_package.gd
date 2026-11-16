class_name DamagePackage extends RefCounted



var source_entity: Entity

var amount: int









static func create(attack_entry: AttackEntry, _source_entity: Entity = null) -> DamagePackage:

	var damage_package = DamagePackage.new()

	damage_package.amount = attack_entry.damage

	damage_package.source_entity = _source_entity

	return damage_package