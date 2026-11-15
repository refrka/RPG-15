class_name StateMachine extends Node



@export var body_root: Node

@export var combat_root: Node

@export var initial_body_state: BodyState

@export var initial_combat_state: CombatState


var body_states: Dictionary[Script, BodyState]

var combat_states: Dictionary[Script, CombatState]


var active:= false

var entity: Entity


var current_body_state: BodyState

var current_combat_state: CombatState





func initialize(_entity: Entity) -> void:

	entity = _entity

	if body_root:

		for state in body_root.get_children():

			body_states[state.get_script()] = state

			state.initialize(_entity)

	if combat_root:

		for state in combat_root.get_children():

			combat_states[state.get_script()] = state

			state.initialize(_entity)

	current_body_state = initial_body_state

	current_combat_state = initial_combat_state







func activate() -> void:

	active = true

	if current_body_state:

		current_body_state.activate()

	if current_combat_state:

		current_combat_state.activate()



func deactivate() -> void:

	active = false

	if current_body_state:

		current_body_state.deactivate()

	if current_combat_state:

		current_combat_state.deactivate()






func _physics_process(delta: float) -> void:

	if not active:

		return

	if current_body_state:

		current_body_state.tick(delta)

	if current_combat_state:

		current_combat_state.tick(delta)