class_name Effect extends Resource


var target_entity: Entity

var time_alive:= 0.0




func apply(_target_entity: Entity) -> void:

	target_entity = _target_entity





func tick(delta: float) -> void:

	time_alive += delta

