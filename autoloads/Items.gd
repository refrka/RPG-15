extends Node


var item_registry: Dictionary[StringName, Item]

var recipe_registry: Dictionary[StringName, CraftingRecipe]






func load_items() -> void:

	var dirs = ["res://main/items/"]

	while not dirs.is_empty():

		var dir = dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(dir):

			var path = dir + dir_name

			if dir_name.ends_with("/"):

				dirs.append(path)

			elif dir_name.ends_with(".tres"):

				var item = load(path) as Item

				item_registry[item.item_id] = item




func load_recipes() -> void:

	var dirs = ["res://main/crafting/recipes/"]

	while not dirs.is_empty():

		var dir = dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(dir):

			var path = dir + dir_name

			if dir_name.ends_with("/"):

				dirs.append(path)

			elif dir_name.ends_with(".tres"):

				var recipe = load(path) as CraftingRecipe

				recipe_registry[recipe.recipe_id] = recipe