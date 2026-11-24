class_name Hitbox extends Sensor


signal hit_detected(hurtbox: Hurtbox)


var entity_ref_blacklist:= []

var hurtbox_blacklist:= []

var hit_list: Array





func clear_hit_list() -> void:

	hit_list.clear()



func can_hit(hurtbox: Hurtbox) -> bool:

	if hurtbox_blacklist.has(hurtbox):

		return false

	for entity_ref in entity_ref_blacklist:

		if entity_ref.matches(hurtbox.entity):

			return false

	return true



func hit(hurtbox: Hurtbox) -> void:

	hit_detected.emit(hurtbox)

	hit_list.append(hurtbox)




func _on_area_entered(area: Area2D) -> void:

	super(area)

	if sensors.has(area) and area is Hurtbox and area.active and can_hit(area):

		hit(area)


