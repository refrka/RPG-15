class_name Behavior extends Resource



@export var phases: Array[BehaviorPhase]

var phase_index:= -1



var entity: Entity





func initialize(_entity: Entity) -> void:

	entity = _entity





func start_phase(index: int) -> void:

	phase_index = index

	var phase = get_phase(phase_index)

	phase.command_data["actor"] = entity

	phase.ended.connect(_on_phase_ended.bind(phase), CONNECT_ONE_SHOT)

	phase.execute_index(0)




func get_phase(index: int) -> BehaviorPhase:

	if phases.size() - 1 >= index:

		return phases[index]

	return null




func _on_phase_ended(phase: BehaviorPhase) -> void:

	var next_index = phase.next_index

	if next_index == -1:

		start_phase(phase_index)