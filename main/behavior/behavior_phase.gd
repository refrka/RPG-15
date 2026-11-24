class_name BehaviorPhase extends Resource


signal ended


@export var next_index:= -1

@export var commands: Array[Command]

var command_index:= -1

var command_data:= {}




func start() -> void:

	execute_index(0)



func end() -> void:

	var current_command = get_command(command_index)

	if current_command.result == Command.Result.PENDING:

		current_command.cancel()




func execute_index(index: int) -> void:

	command_index = index

	var command = get_command(index)

	if not command:

		return

	match command.execute(command_data):

		Command.Result.PENDING:

			command.command_executed.connect(_on_command_executed, CONNECT_ONE_SHOT)

		Command.Result.SUCCESS:

			_on_command_executed()
		




func get_command(index: int) -> Command:

	if commands.size() - 1 >= index:

		return commands[index]

	return null




func _on_command_executed() -> void:

	var next_command_index = command_index + 1

	if commands.size() - 1 < next_command_index:

		ended.emit()

	else:

		execute_index(next_command_index)