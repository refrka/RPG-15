class_name MovementSensor extends Sensor


@export var move_speed_override:= 1.0


var modifiers: Dictionary[Entity, Modifier]



func _ready() -> void:

	var parent = get_parent()

	if parent is Entity:

		initialize(parent)

	else:

		initialize()

	activate()



func initialize(_entity: Entity = null) -> void:

	super(_entity)

	entity_entered.connect(_on_entity_entered)

	entity_exited.connect(_on_entity_exited)




func _on_entity_entered(_entity: Entity) -> void:

	var movement_component = _entity.get_component(MovementComponent)

	if movement_component:

		var modifier = Modifier.new_passive(move_speed_override, Modifier.Operator.MULTIPLY)

		movement_component.modifier_tracker.add_modifier(modifier)

		modifiers[_entity] = modifier




func _on_entity_exited(_entity: Entity) -> void:

	if modifiers.has(_entity):

		var modifier = modifiers[_entity]

		var movement_component = _entity.get_component(MovementComponent)

		movement_component.modifier_tracker.remove_modifier(modifier)