class_name Player extends Character


@export var tool_icon_rect: ToolIconRect


var saved_spawn_id: StringName

var known_recipes: Array[CraftingRecipe]



func initialize() -> bool:

	if not super():

		return false

	Events.fire_script(PlayerInitializedEvent)

	return true



func get_component(script: Script) -> Component:

	script = PlayerMovementComponent if script == MovementComponent else script

	return super(script)















func add_known_recipe(recipe: CraftingRecipe) -> void:

	if not known_recipes.has(recipe):

		known_recipes.append(recipe)

		Events.fire_script(RecipeLearnedEvent, {"recipe": recipe}, true)