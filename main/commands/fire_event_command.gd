class_name FireEventCommand extends Command


@export var event: Event

@export var with_notice:= false


func execute(_data:= {}) -> Result:

	super(_data)

	Events.fire_event(event, with_notice)

	result = Result.SUCCESS

	return result