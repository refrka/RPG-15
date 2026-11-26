extends Node



var subscriptions:= {}




func subscribe(event_script: Script, callback: Callable) -> void:

	if not subscriptions.has(event_script):

		subscriptions[event_script] = []

	if not subscriptions[event_script].has(callback):

		subscriptions[event_script].append(callback)





func unsubscribe(event_script: Script, callback: Callable) -> void:

	if subscriptions.has(event_script) and subscriptions[event_script].has(callback):

		subscriptions[event_script].erase(callback)

		if subscriptions[event_script].is_empty():

			subscriptions.erase(event_script)





func fire_script(event_script: Script, data:= {}, with_notice:= false) -> void:

	var event = event_script.new()

	event.fire(data)

	if with_notice:

		Notices.new_notice(event.get_notice_message())

	if subscriptions.has(event_script):

		var callbacks = subscriptions[event_script]

		for callback in callbacks:

			callback.call(event)

		





func fire_event(event: Event, with_notice:= false) -> void:

	var script = event.get_script()

	var data = event.data

	fire_script(script, data, with_notice)
	