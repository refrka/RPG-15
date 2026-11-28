class_name SignComponent extends InteractableComponent






func start() -> void:

	print("start")

	Dialogue.open_dialogue(entity)

	Dialogue.dialogue_closed.connect(_on_dialogue_closed, CONNECT_ONE_SHOT)




func end() -> void:

	if Dialogue.dialogue_closed.is_connected(_on_dialogue_closed):

		Dialogue.dialogue_closed.disconnect(_on_dialogue_closed)

	Dialogue.close_dialogue()




func _on_dialogue_closed() -> void:

	closed.emit()