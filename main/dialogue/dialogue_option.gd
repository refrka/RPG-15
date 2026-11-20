class_name DialogueOption extends Resource


@export var persist:= false

@export var gate_conditions: Array[Condition]

@export_multiline var text: String

@export var node: DialogueNode

@export var forced_greeting: DialogueGreeting

@export var on_select_command_set: CommandSet





func passes_conditions() -> bool:

	for condition in gate_conditions:

		if not condition.evaluate():

			return false

	return true