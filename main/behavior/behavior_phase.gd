class_name BehaviorPhase extends Resource


signal phase_index_requested(index: int)


@export var commands: Array[Command]

@export var next_phase:= -1


var actor: Entity

var command_index:= -1

var command_data:= {}





func start() -> void:

	command_data["actor"] = actor

	execute_command(0)



func end() -> void:

	if command_index != -1:

		var command = commands[command_index]

		if command.result == Command.Result.PENDING:

			command.command_executed.disconnect(_on_command_executed)

			command.cancel()

	command_index = -1



func execute_command(index: int) -> void:

	if commands.size() - 1 < index:

		command_index = -1

		phase_index_requested.emit(next_phase)

		return

	command_index = index

	var command = commands[index]

	match command.execute(command_data):

		Command.Result.SUCCESS:

			execute_command(command_index + 1)

		Command.Result.PENDING:

			command.command_executed.connect(_on_command_executed, CONNECT_ONE_SHOT)






func _on_command_executed() -> void:

	execute_command(command_index + 1)