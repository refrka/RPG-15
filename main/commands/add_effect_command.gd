class_name AddEffectCommand extends Command



@export var entity_ref: EntityRef

@export var effect: Effect



func execute(_data:= {}) -> Result:

	super(_data)

	var entity = Game.player

	if _data.has("entity"):

		entity = _data.entity

	if _data.has("effect"):

		effect = _data.effect

	var effects_component = entity.get_component(EffectsComponent)

	effects_component.add_effect(effect)

	result = Result.SUCCESS

	return result