class_name Player extends Character




func initialize() -> bool:

	super()

	var combat_component = get_component(CombatComponent)

	var weapon = load("res://main/items/equipment/weapons/sword.tres")

	var item_stack = ItemStack.create(weapon)

	combat_component.load_weapon(item_stack)

	return true



func get_component(script: Script) -> Component:

	script = PlayerMovementComponent if script == MovementComponent else script

	return super(script)