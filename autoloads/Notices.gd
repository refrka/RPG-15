extends Node


@onready var notice_scene:= preload("res://ui/notice.tscn")


var notice_root: Control



var active_notices: Array[Notice]



func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	notice_root = get_tree().get_first_node_in_group("notice_root")






func new_notice(message: String) -> void:

	var notice = notice_scene.instantiate() as Notice

	notice.message_label.text = message

	notice.expired.connect(_on_notice_expired.bind(notice))

	for _notice in active_notices:

		var tween = get_tree().create_tween()

		tween.tween_property(_notice, "global_position:y", _notice.global_position.y - 25, 0.1)

	active_notices.append(notice)

	notice_root.add_child(notice)

	notice.size = Vector2.ZERO




func _on_notice_expired(notice: Notice) -> void:

	var tween = get_tree().create_tween()

	tween.finished.connect(_on_fade_tween_finished.bind(notice))

	tween.tween_property(notice, "modulate:a", 0.0, 1.0)



func _on_fade_tween_finished(notice: Notice) -> void:

	notice.queue_free()

	active_notices.erase(notice)