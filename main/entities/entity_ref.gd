class_name EntityRef extends Resource



@export var entity_id: StringName

@export var authored_id: StringName





func matches(entity: Entity) -> bool:

	var is_match:= true

	if entity_id != "" and entity.entity_id != entity_id:

		is_match = false

	if authored_id and entity.authored_id != authored_id:

		is_match = false

	return is_match

	