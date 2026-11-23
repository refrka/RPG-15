class_name BehaviorComponent extends Component




@export var default_behavior: Behavior





var current_behavior: Behavior



func initialize(_entity: Entity) -> void:

	super(_entity)

	if default_behavior:

		default_behavior.initialize(entity)



func activate() -> void:

	super()

	if default_behavior:

		start_behavior(default_behavior)




func start_behavior(behavior: Behavior) -> void:

	current_behavior = behavior

	current_behavior.start_phase(0)