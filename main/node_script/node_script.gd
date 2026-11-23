class_name NodeScript extends Node


var data:={}

var process_callback: Callable

var physics_callback: Callable






func _process(delta: float) -> void:

	if process_callback != null and process_callback.is_valid():

		process_callback.call(delta, self)




func _physics_process(delta: float) -> void:

	if physics_callback and physics_callback.is_valid():

		physics_callback.call(delta, self)




static func new_process(callback: Callable, _data:= {}) -> NodeScript:

	var node = NodeScript.new()

	node.process_callback = callback

	node.data = _data

	return node