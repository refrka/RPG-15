class_name Notice extends MarginContainer

signal expired

@export var message_label: Label

@export var duration:= 3.0

@export var anim_player: AnimationPlayer

var timer:= 0.0

var timer_active:= false



func _ready() -> void:

	timer_active = true



func _process(delta: float) -> void:

	if not timer_active:

		return

	timer += delta

	if timer >= duration:

		timer_active = false

		expired.emit()