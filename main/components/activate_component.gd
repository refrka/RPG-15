class_name ActivateComponent extends InteractableComponent




@export var activate_command_set: CommandSet




func initialize(_entity: Entity) -> void:

	super(_entity)

	if not activate_command_set:

		return

	activate_command_set.all_commands_executed.connect(_on_all_commands_executed)





func can_interact() -> bool:

	if not activate_command_set:

		return false

	if activate_command_set.is_executing():

		return false

	return true




func start() -> void:

	animation_component.play_body_animation("%s/activate" % entity.entity_id)

	activate_command_set.execute_all()






func _on_all_commands_executed() -> void:

	complete()