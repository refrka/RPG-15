extends Node



var dialogue_overlay: DialogueOverlay


var current_dialogue_source: Entity

var current_dialogue_node: DialogueNode





func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS





func set_dialogue_source(source: Entity) -> void:

	current_dialogue_source = source

	dialogue_overlay.texture_rect.texture = current_dialogue_source.speaker_texture





func get_root_options(entity: Entity) -> Array:

	var root_options = []

	# Fetch root options from the entity's library

	if entity.dialogue_library:

		for option in entity.dialogue_library.root_options:

			var passed:= true

			for condition in option.gate_conditions:

				if not condition.evaluate({"speaker": entity}):

					passed = false

			if passed:

				root_options.append(option)

	# Fetch appropriate root options from quests

	return root_options