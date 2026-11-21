extends Node



var overlays: Dictionary[Script, Overlay]

var active_overlays: Array

var pause_count:= 0



var player_health_bar: HealthBar




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	for overlay in get_tree().get_nodes_in_group("overlay"):

		overlays[overlay.get_script()] = overlay

		overlay.hide()

	player_health_bar = get_tree().get_first_node_in_group("player_health_bar")

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)





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





func _on_player_initialized(_event: Event) -> void:

	var health_component = Game.player.get_component(HealthComponent)

	player_health_bar.load_health_component(health_component)
	



func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back") and Inputs.is_action_allowed("back"):

		if not active_overlays.is_empty():

			remove_overlay(active_overlays.back())