class_name Weapon extends Equipment


enum WeaponType {

	MELEE,

	RANGED,

}


@export var weapon_type: WeaponType

@export var attack_entry: AttackEntry

@export var weapon_scene: PackedScene

@export var default_ammunition: Ammunition

@export var default_charge:= 5

@export var attack_cooldown:= 0.0