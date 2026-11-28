class_name MovementModifierDurationEffect extends DurationEffect



@export var override:= false

@export var speed_value:= -1.0

@export var vector_value:= Vector2.ZERO

var speed_modifier: Modifier

var vector_modifier: Modifier



func apply(_target_entity: Entity) -> void:

	super(_target_entity)

	var movement_component = target_entity.get_component(MovementComponent)

	var operator_override = Modifier.Operator.OVERRIDE

	if movement_component:

		if speed_value != 1.0:

			speed_modifier = Modifier.new_duration(speed_value, duration, operator_override if override else Modifier.Operator.MULTIPLY)

		if vector_value != Vector2.ZERO:

			vector_modifier = Modifier.new_duration(vector_value, duration, operator_override if override else Modifier.Operator.ADD)

	if speed_modifier:

		movement_component.modifier_tracker.add_modifier(speed_modifier)

	if vector_modifier:

		movement_component.modifier_tracker.add_modifier(vector_modifier)




func expire() -> void:

	var movement_component = target_entity.get_component(MovementComponent)

	if movement_component:

		if speed_modifier:

			movement_component.modifier_tracker.remove_modifier(speed_modifier)

		if vector_modifier:

			movement_component.modifier_tracker.remove_modifier(vector_modifier)