class_name AnimationComponent extends Component

signal death_animation_finished

@export var combat_anim_player: AnimationPlayer

@export var y_sprite_frames:= Vector2i(0,1)



var movement_component: MovementComponent



func initialize(_entity: Entity) -> void:
	
	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_updated.connect(_on_face_dir_updated)

	entity.body_anim_player.animation_finished.connect(_on_body_anim_finished)




func update_face_dir(dir: Vector2) -> void:

	entity.body_sprite.flip_h = dir.x < 0

	entity.body_sprite.frame = y_sprite_frames.x if dir.y >= 0 else y_sprite_frames.y



func play_body_animation(anim_name: String) -> void:

	if entity.body_anim_player.has_animation(anim_name):

		entity.body_anim_player.play(anim_name)





func _on_damage_package_received(_damage_package: DamagePackage) -> void:

	var anim_name = "%s/flinch" % entity.entity_id if entity.body_anim_player.has_animation("%s/flinch" % entity.entity_id) else "flinch"

	entity.body_anim_player.play(anim_name)




func _on_death() -> void:

	if entity.body_anim_player.current_animation.ends_with("flinch"):

		await entity.body_anim_player.animation_finished

	var anim_name = "%s/die" % entity.entity_id if entity.body_anim_player.has_animation("%s/die" % entity.entity_id) else "die"

	print(anim_name)

	if anim_name != "":

		entity.body_anim_player.play(anim_name)




func _on_body_anim_finished(anim_name: StringName) -> void:

	if anim_name.ends_with("die"):

		death_animation_finished.emit()




func _on_face_dir_updated(dir: Vector2) -> void:

	update_face_dir(dir)




func _on_move_started() -> void:

	var anim_name = "%s/move_%s" % [entity.entity_id, movement_component.get_face_dir_string()]

	if entity.body_anim_player.has_animation(anim_name):
		
		entity.body_anim_player.play(anim_name)




func _on_move_ended() -> void:

	entity.body_anim_player.play("RESET")