class_name RecipeLearnedEvent extends GameEvent







func get_notice_message() -> String:

	return "Learned recipe: %s" % data.recipe.product.display_name