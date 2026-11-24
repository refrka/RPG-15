class_name JournalTab extends MarginContainer


@onready var quest_panel_scene:= preload("res://ui/journal_quest_panel.tscn")




@export var quest_tab_button_group: ButtonGroup

@export var active_quests_vbox: VBoxContainer

@export var completed_quests_vbox: VBoxContainer


var selected_quest_panel: JournalQuestPanel



func _ready() -> void:

	quest_tab_button_group.pressed.connect(_on_tab_pressed)

	quest_tab_button_group.get_buttons()[0].button_pressed = true

	quest_tab_button_group.get_buttons()[0].pressed.emit()




func open() -> void:

	load_quest_panels()

	show()




func close() -> void:

	hide()




func load_quest_panels() -> void:

	clear_quest_panels()

	var ready_quests = Quests.get_quest_data_with_state(Quest.QuestState.READY)

	var active_quests = Quests.get_quest_data_with_state(Quest.QuestState.ACTIVE)

	var completed_quests = Quests.get_quest_data_with_state(Quest.QuestState.COMPLETE)

	for quest_data in ready_quests:

		var panel = quest_panel_scene.instantiate()

		active_quests_vbox.add_child(panel)

		panel.panel_selected.connect(_on_quest_panel_selected.bind(panel))

		panel.load_quest_data(quest_data)

	for quest_data in active_quests:

		var panel = quest_panel_scene.instantiate()

		active_quests_vbox.add_child(panel)

		panel.panel_selected.connect(_on_quest_panel_selected.bind(panel))

		panel.load_quest_data(quest_data)

	for quest_data in completed_quests:

		var panel = quest_panel_scene.instantiate()

		completed_quests_vbox.add_child(panel)

		panel.panel_selected.connect(_on_quest_panel_selected.bind(panel))

		panel.load_quest_data(quest_data)




func clear_quest_panels() -> void:

	for panel in active_quests_vbox.get_children():

		panel.queue_free()

	for panel in completed_quests_vbox.get_children():

		panel.queue_free()





func _on_quest_panel_selected(panel: JournalQuestPanel) -> void:

	if selected_quest_panel:

		selected_quest_panel.shrink()

	if panel == selected_quest_panel:

		selected_quest_panel = null

		return

	selected_quest_panel = panel

	panel.expand()





func _on_tab_pressed(button: Button) -> void:

	for _button in quest_tab_button_group.get_buttons():

		if _button == button:

			_button.tab.show()

		else:

			_button.tab.hide()

