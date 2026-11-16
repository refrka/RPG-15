class_name Weapon extends Equipment


enum WeaponType {

	MELEE,

	RANGED,

}


@export var weapon_type: WeaponType

@export var weapon_scene: PackedScene