class_name TransitionZone extends Feature


@export var location_id: StringName

@export var spawn_id: StringName


func initialize() -> void:

	self.body_entered.connect(_on_body_entered, CONNECT_ONE_SHOT)

	



func _on_body_entered(_body: PhysicsBody2D) -> void:

	if not active:

		return

	deactivate()

	Game.player.state_machine.request_state(BodyIdleState)

	Scenes.transition_to.call_deferred(location_id, spawn_id)