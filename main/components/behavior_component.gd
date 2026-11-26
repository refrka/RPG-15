class_name BehaviorComponent extends Component



enum Temperament {

	PASSIVE,

	AGGRESSIVE,

	DEFENSIVE

}


@export var aggressive:= false

@export var passive_behavior: Behavior

@export var defensive_behavior: Behavior

@export var aggressive_behavior: Behavior





var current_behavior: Behavior

var player: Player



func initialize(_entity: Entity) -> void:

	super(_entity)

	entity.vision_sensor.entity_position_updated.connect(_on_entity_position_updated)

	if passive_behavior:

		passive_behavior.actor = entity

		passive_behavior.initialize()

		current_behavior = passive_behavior




func activate() -> void:

	super()

	if current_behavior:

		current_behavior.start()



func deactivate() -> void:

	super()

	if current_behavior:

		current_behavior.end()




func change_change(behavior: Behavior) -> void:

	current_behavior = behavior

	

