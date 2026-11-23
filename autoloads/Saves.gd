extends Node


const SAVE_PATH = "user://save.json"

var last_save_dict:= {}




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	last_save_dict = read_dict_from_file()




func create_save(save_name: StringName) -> void:

	var data = load("res://system/save_template.gd").new().data

	data["save_name"] = save_name

	write_dict_to_file(data)

	Game.start(Game.root.launch_mode)




func delete_save() -> void:

	if FileAccess.file_exists(SAVE_PATH):
		
		DirAccess.remove_absolute(SAVE_PATH)

	last_save_dict = {}

	Game.start(Game.root.launch_mode)




func write_dict_to_file(dict: Dictionary) -> void:

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	dict["last_save_unix"] = Time.get_unix_time_from_system()

	file.store_string(JSON.stringify(dict, " "))

	file.close()

	last_save_dict = dict




func read_dict_from_file() -> Dictionary:

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if not file:

		return {}

	var json = JSON.new()

	json.parse(file.get_as_text())

	file.close()

	return json.data