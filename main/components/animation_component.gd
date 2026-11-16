class_name AnimationComponent extends Component


@export var combat_anim_player: AnimationPlayer

@export var y_sprite_frames:= Vector2i(0,1)





func initialize(_entity: Entity) -> void:
	
	super(_entity)

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_updated.connect(_on_face_dir_changed)




func update_face_dir(dir: Vector2) -> void:

	entity.body_sprite.flip_h = dir.x < 0

	entity.body_sprite.frame = y_sprite_frames.x if dir.y >= 0 else y_sprite_frames.y






func _on_face_dir_changed(dir: Vector2) -> void:

	update_face_dir(dir)