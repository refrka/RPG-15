class_name EffectsComponent extends Component



var active_effects: Array[Effect]




func add_effect(effect: Effect) -> void:
	
	if effect is DurationEffect and effect.duration > 0.0:

		active_effects.append(effect)
	
	effect.apply(entity)

	

func remove_effect(effect: Effect) -> void:

	if active_effects.has(effect):

		active_effects.erase(effect)

	




func _process(delta: float) -> void:

	if not active:

		return

	for effect in active_effects:

		effect.tick(delta)