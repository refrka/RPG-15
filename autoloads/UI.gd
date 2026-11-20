extends Node



var overlays: Dictionary[Script, Overlay]

var active_overlays: Array

var pause_count:= 0




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	for overlay in get_tree().get_nodes_in_group("overlay"):

		overlays[overlay.get_script()] = overlay

		overlay.hide()





func add_overlay(overlay: Overlay) -> void:

	if active_overlays.has(overlay):

		return

	active_overlays.append(overlay)

	if overlay.pause:

		pause_count += 1

		if not Game.is_paused():

			Game.pause()

	overlay.open()

	

func remove_overlay(overlay: Overlay) -> void:

	if not active_overlays.has(overlay):

		return

	active_overlays.erase(overlay)

	overlay.close()

	if overlay.pause:

		pause_count -= 1

		if Game.is_paused() and pause_count <= 0:

			Game.unpause()





func get_overlay(script: Script) -> Overlay:

	if overlays.has(script):

		return overlays[script]
	
	return null





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back") and Inputs.is_action_allowed("back"):

		if not active_overlays.is_empty():

			remove_overlay(active_overlays.back())