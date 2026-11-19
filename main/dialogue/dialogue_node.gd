class_name DialogueNode extends Resource






@export var text: DialogueText

@export var options: Array[DialogueOption]

@export var enter_command_set: CommandSet

@export var exit_command_set: CommandSet

@export var force_enter:= false





static func from_greeting(greeting: DialogueGreeting, _options: Array[DialogueOption]) -> DialogueNode:

	var node = DialogueNode.new()

	node.text = greeting

	node.options = _options

	return node

