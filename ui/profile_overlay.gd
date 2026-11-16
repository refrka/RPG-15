class_name ProfileOverlay extends Overlay







func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile") and Inputs.is_action_allowed("profile"):

		if not is_visible_in_tree():

			UI.add_overlay(self)

		else: 
			
			UI.remove_overlay(self)