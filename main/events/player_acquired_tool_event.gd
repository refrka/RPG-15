class_name PlayerAcquiredToolEvent extends GameEvent



func get_notice_message() -> String:

	return "You acquired the %s" % data.tool.display_name