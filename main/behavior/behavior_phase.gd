class_name BehaviorPhase extends Resource


signal ended


@export var next_index:= -1

@export var commands: Array[Command]

var command_index:= -1

var command_data:= {}




func start() -> void:

	execute_index(0)




func execute_index(index: int) -> void:

	command_index = index

	var command = get_command(index)

	if not command:

		return

	match command.execute(command_data):

		Command.Result.PENDING:

			command.command_executed.connect(_on_command_executed)




func get_command(index: int) -> Command:

	if commands.size() - 1 >= index:

		return commands[index]

	return null




func _on_command_executed() -> void:

	execute_index(command_index + 1)