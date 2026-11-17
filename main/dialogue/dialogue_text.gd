class_name DialogueText extends Resource



@export_multiline var lines: Array[String]



func get_line(index: int) -> String:

	return "" if lines.size() - 1 < index else lines[index]