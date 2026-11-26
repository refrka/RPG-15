class_name BodyState extends State




var movement_component: MovementComponent

var animation_component: AnimationComponent



func initialize(_entity: Entity, _state_machine: StateMachine) -> void:

	super(_entity, _state_machine)

	movement_component = entity.get_component(MovementComponent)

	animation_component = entity.get_component(AnimationComponent)