class_name Behavior extends Resource




@export var phases: Array[BehaviorPhase]

var actor: Entity

var phase_index:= -1

var current_phase: BehaviorPhase



func initialize() -> void:

	for phase in phases:

		phase.actor = actor

		phase.phase_index_requested.connect(_on_phase_index_requested)



func start() -> void:

	start_phase(0)



func end() -> void:

	if current_phase:

		current_phase.phase_index_requested.disconnect(_on_phase_index_requested)




func start_phase(index: int) -> void:

	if phases.size() - 1 < index:

		return

	if current_phase:

		current_phase.end()

	phase_index = index

	var phase = phases[index]

	if phase:

		current_phase = phase

		phase.start()






func _on_phase_index_requested(index: int) -> void:

	start_phase(index)