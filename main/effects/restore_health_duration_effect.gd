class_name RestoreHealthDurationEffect extends DurationEffect


@export var amount: int



func apply(_target_entity: Entity) -> void:

	super(_target_entity)

	var health_component = target_entity.get_component(HealthComponent)

	health_component.restore_health(amount)