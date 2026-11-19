extends Node


signal dialogue_opened

signal dialogue_closed


var dialogue_overlay: DialogueOverlay


var current_source: Entity

var current_library: DialogueLibrary

var current_node: DialogueNode

var current_options: Array

var selected_options: Array

var dialogue_data:= {}




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	dialogue_overlay = get_tree().get_first_node_in_group("dialogue_overlay")
	
	dialogue_overlay.closed.connect(_on_dialogue_overlay_closed)

	dialogue_overlay.last_line_shown.connect(_on_last_line_shown)

	dialogue_overlay.option_selected.connect(_on_dialogue_option_selected)




func try_dialogue(entity: Entity) -> void:

	if entity.dialogue_library:

		open_dialogue(entity)




func open_dialogue(entity: Entity) -> void:

	set_dialogue_source(entity)

	UI.add_overlay(dialogue_overlay)

	var root_options = get_root_options(current_source)

	var greeting = get_greeting(root_options)

	var node = DialogueNode.from_greeting(greeting, root_options)

	set_dialogue_node(node)

	dialogue_opened.emit()





func close_dialogue() -> void:

	UI.remove_overlay(dialogue_overlay)

	current_node = null

	current_library = null

	current_options.clear()

	selected_options.clear()

	dialogue_closed.emit()




func set_options(options: Array[DialogueOption]) -> void:

	dialogue_overlay.clear_options()

	for option in current_options:

		if option.persist and not selected_options.has(option):

			options.append(option)

	current_options = options

	dialogue_overlay.add_options(current_options)




func set_dialogue_source(source: Entity) -> void:

	current_source = source

	dialogue_overlay.texture_rect.texture = current_source.speaker_texture

	current_library = source.dialogue_library




func set_dialogue_node(dialogue_node: DialogueNode) -> void:
	
	if current_node and current_node.exit_command_set:

		current_node.exit_command_set.execute_all()

	current_node = dialogue_node

	set_dialogue_text(current_node.text)

	set_options(current_node.options)

	if current_node.enter_command_set:

		current_node.enter_command_set.execute_all()




func set_dialogue_text(dialogue_text: DialogueText) -> void:

	dialogue_overlay.set_dialogue_text(dialogue_text)




func get_force_enter_nodes(entity: Entity) -> Array:

	var dialogue_nodes = []

	# Search active quests for dialogue nodes tat pass conditions and are force_enter = true

	return dialogue_nodes



func get_root_options(entity: Entity = null) -> Array[DialogueOption]:

	var root_options: Array[DialogueOption] = []

	# Fetch root options from the entity's library

	if not entity:

		return root_options

	if entity.dialogue_library:

		for option in entity.dialogue_library.root_options:

			var passed:= true

			for condition in option.gate_conditions:

				if not condition.evaluate({"speaker": entity}):

					passed = false

			if passed:

				root_options.append(option)

	var quest_options = Quests.get_root_options(entity)

	for option in quest_options:

		root_options.append(option)

	return root_options



func get_greeting(options:= []) -> DialogueGreeting:

	for option in options:

		if option.forced_greeting:

			return option.forced_greeting

	if not current_library.greetings.is_empty():

		return current_library.greetings.pick_random()

	return null







func _on_dialogue_overlay_closed() -> void:

	close_dialogue()




func _on_last_line_shown() -> void:

	pass




func _on_dialogue_option_selected(option: DialogueOption) -> void:

	selected_options.append(option)

	set_dialogue_node(option.node)