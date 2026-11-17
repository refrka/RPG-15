class_name Hitbox extends Sensor


signal hit_detected(hurtbox: Hurtbox)


var hit_list: Array



func _on_area_entered(area: Area2D) -> void:

	super(area)

	if sensors.has(area) and area is Hurtbox:

		hit(area)






func hit(hurtbox: Hurtbox) -> void:

	hit_detected.emit(hurtbox)