extends Node



var overlays: Dictionary[Script, Overlay]

var pause_count:= 0




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	for overlay in get_tree().get_nodes_in_group("overlay"):

		overlays[overlay.get_script()] = overlay

		overlay.hide()





func add_overlay(overlay: Overlay) -> void:

	overlay.show()

	if overlay.pause:

		pause_count += 1

		if not Game.is_paused():

			Game.pause()

	

func remove_overlay(overlay: Overlay) -> void:

	overlay.hide()

	if overlay.pause:

		pause_count -= 1

		if Game.is_paused() and pause_count <= 0:

			Game.pause()