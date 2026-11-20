class_name Hitbox extends Sensor


signal hit_detected(hurtbox: Hurtbox)


var hit_list: Array





func clear_hit_list() -> void:

	hit_list.clear()



func hit(hurtbox: Hurtbox) -> void:

	hit_detected.emit(hurtbox)

	hit_list.append(hurtbox)




func _on_area_entered(area: Area2D) -> void:

	super(area)

	if sensors.has(area) and area is Hurtbox and area.active and not hit_list.has(area):

		hit(area)


