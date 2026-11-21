class_name HealthBar extends MarginContainer


@export var progress_bar: ProgressBar




func load_health_component(health_component: HealthComponent) -> void:

	progress_bar.max_value = health_component.max_health

	progress_bar.value = health_component.current_health

	health_component.health_changed.connect(_on_health_changed)



func _on_health_changed(new_health: int) -> void:

	progress_bar.value = new_health