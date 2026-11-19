class_name DialogueOverlay extends Overlay


signal last_line_shown

signal option_selected(option: DialogueOption)


@onready var option_button_scene:= preload("res://ui/dialogue_option_button.tscn")


@export var texture_rect: TextureRect

@export var text_label: RichTextLabel

@export var input_bg_vbox: VBoxContainer

@export var option_vbox: VBoxContainer

@export var close_button: Button

@export var anim_player: AnimationPlayer



var dialogue_text: DialogueText

var line_index:= 0



func _ready() -> void:

	input_bg_vbox.gui_input.connect(_on_dialogue_gui_input)

	close_button.pressed.connect(_on_close_pressed)




func set_dialogue_text(_dialogue_text: DialogueText) -> void:

	dialogue_text = _dialogue_text

	line_index = 0

	show_line(line_index)





func show_line(index: int) -> void:

	anim_player.stop()

	if dialogue_text.lines.size() - 1 >= index:

		line_index = index

		text_label.text = dialogue_text.lines[index]

		if index == dialogue_text.lines.size() - 1:

			last_line_shown.emit()

		else:

			anim_player.play("blink")






func clear_options() -> void:

	for button in option_vbox.get_children():

		button.queue_free()




func add_options(options: Array) -> void:

	for option in options:

		add_option(option.text).pressed.connect(_on_option_selected.bind(option))




func add_option(option_text: String) -> DialogueOptionButton:

	var button = option_button_scene.instantiate()

	button.text = option_text

	option_vbox.add_child(button)

	return button




func _on_dialogue_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		var next_index = line_index + 1

		show_line(next_index)




func _on_close_pressed() -> void:

	close()



func _on_option_selected(option: DialogueOption) -> void:

	option_selected.emit(option)