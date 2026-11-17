class_name ExpirationTimer extends Timer



func _ready() -> void:

	timeout.connect(_on_timeout)




func _on_timeout() -> void:

	get_parent().queue_free()