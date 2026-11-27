class_name BehaviorComponent extends Component



enum Temperament {

	PASSIVE,

	AGGRESSIVE,

	DEFENSIVE

}


@export var temperament: Temperament

@export var passive_behavior: Behavior

@export var defensive_behavior: Behavior

@export var aggressive_behavior: Behavior





var current_behavior: Behavior

var player: Player



func initialize(_entity: Entity) -> void:

	super(_entity)

	if passive_behavior:

		passive_behavior.actor = entity

		passive_behavior.initialize()

		current_behavior = passive_behavior

	entity.vision_sensor.entity_entered.connect(_on_entity_entered_vision_sensor)






func activate() -> void:

	super()

	if current_behavior:

		current_behavior.start()



func deactivate() -> void:

	super()

	if current_behavior:

		current_behavior.end()




func change_behavior(behavior: Behavior) -> void:

	if current_behavior:

		current_behavior.end()

	current_behavior = behavior

	current_behavior.start()






func _on_entity_entered_vision_sensor(_entity: Entity) -> void:

	match temperament:

		Temperament.PASSIVE:

			pass

		Temperament.AGGRESSIVE:

			if aggressive_behavior:

				change_behavior(aggressive_behavior)

		Temperament.DEFENSIVE:

			if defensive_behavior:

				change_behavior(defensive_behavior)