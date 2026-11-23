class_name InteractableComponent extends Component


@warning_ignore_start("unused_signal")

signal completed

signal ended

signal closed

signal cancelled



@export var required_tool: Tool


var animation_component: AnimationComponent



func initialize(_entity: Entity) -> void:

	super(_entity)

	animation_component = entity.get_component(AnimationComponent)



func can_interact() -> bool:

	return true


func can_end() -> bool:

	return  true



func start() -> void:

	completed.emit()



func end() -> void:

	pass


func cancel() -> void:

	cancelled.emit()


func complete() -> void:

	completed.emit()



func _on_failed_interaction() -> void:

	pass