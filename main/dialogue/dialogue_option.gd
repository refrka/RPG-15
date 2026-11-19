class_name DialogueOption extends Resource


@export var persist:= false

@export var gate_conditions: Array[Condition]

@export_multiline var text: String

@export var node: DialogueNode

@export var forced_greeting: DialogueGreeting