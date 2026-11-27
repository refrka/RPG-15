extends Node


@onready var notice_scene:= preload("res://ui/notice.tscn")


var notice_root: Control



var active_notices: Array[Notice]

var pending_notices: Array[Notice]


var timer:= 0.0



func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	notice_root = get_tree().get_first_node_in_group("notice_root")




func next_notice() -> void:

	if not pending_notices.is_empty():

		var notice = pending_notices.pop_back()
		
		for _notice in active_notices:

			var tween = get_tree().create_tween()

			tween.tween_property(_notice, "global_position:y", _notice.global_position.y - 25, 0.1)

		active_notices.append(notice)

		notice_root.add_child(notice)

		notice.size = Vector2.ZERO

		timer = 0.1




func new_notice(message: String) -> void:

	var notice = notice_scene.instantiate() as Notice

	notice.message_label.text = message

	notice.expired.connect(_on_notice_expired.bind(notice))

	notice.anim_player.animation_finished.connect(_on_notice_animation_finished.bind(notice))

	pending_notices.push_front(notice)




func _on_notice_expired(notice: Notice) -> void:

	notice.anim_player.play("fade")





func _on_fade_tween_finished(notice: Notice) -> void:

	notice.queue_free()

	active_notices.erase(notice)





func _on_notice_animation_finished(anim_name: StringName, notice: Notice) -> void:

	if anim_name == "fade":

		notice.anim_player.animation_finished.disconnect(_on_notice_animation_finished)

		notice.queue_free()

		active_notices.erase(notice)




func _process(delta: float) -> void:

	timer -= delta

	if timer <= 0.0 and not pending_notices.is_empty():

		next_notice()

