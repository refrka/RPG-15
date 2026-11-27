class_name LearnRecipeCommand extends Command


@export var recipe: CraftingRecipe



func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("recipe"):

		recipe = data.recipe

	Game.player.add_known_recipe(recipe)

	result = Result.SUCCESS

	return result