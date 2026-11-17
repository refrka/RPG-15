class_name DialogueOverlay extends Overlay




@export var texture_rect: TextureRect

@export var text_label: RichTextLabel




func _ready() -> void:

	Dialogue.dialogue_overlay = self