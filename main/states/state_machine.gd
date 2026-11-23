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



func reset() -> void:

	entity = null

	body_states.values().map(func(s): s.reset())

	body_states.clear()

	combat_states.values().map(func(s): s.reset())

	combat_states.clear()

	current_body_state = null

	current_combat_state = null





func activate() -> void:

	active = true

	if current_body_state:

		current_body_state.enter()

	if current_combat_state:

		current_combat_state.enter()



func deactivate() -> void:

	active = false

	if current_body_state:

		current_body_state.exit()

	if current_combat_state:

		current_combat_state.exit()





func request_state(script: Script) -> void:

	print("requesting state: ", script)

	if body_states.has(script):

		change_state(body_states[script])

	if combat_states.has(script):

		change_state(combat_states[script])





func change_state(state: State) -> void:

	print("changing to state ", state.name)
	
	if state is BodyState:

		if current_body_state:

			current_body_state.exit()

		current_body_state = state

		current_body_state.enter()

	elif state is CombatState:

		if current_combat_state:

			current_combat_state.exit()

		current_combat_state = state
		
		current_combat_state.enter()





func _physics_process(delta: float) -> void:

	if not active:

		return

	if current_body_state:

		current_body_state.tick(delta)

	if current_combat_state:

		current_combat_state.tick(delta)