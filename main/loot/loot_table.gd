class_name LootTable extends Resource



@export var entries: Array[LootEntry]




func get_loot(_roll: float) -> Array[ItemStack]:

	var loot: Array[ItemStack] = []

	var total_weight = 0

	for entry in entries:

		if entry.weight > 0:

			total_weight += entry.weight

		elif entry.weight == -1:

			for item in entry.items:

				var count = entry.items[item]

				var item_stack: ItemStack = null

				if item.item_id == "coin":

					item_stack = CurrencyStack.create(item, count)

				else:

					item_stack = ItemStack.create(item, count)

				loot.append(item_stack)

	for entry in entries:

		if entry.items.is_empty():

			continue

		if entry.weight > 0:

			var chance = float(entry.weight) / float(total_weight)

			if randf() <= chance:

				for item in entry.items:

					var count = entry.items[item]

					var item_stack: ItemStack = null

					if item.item_id == "coin":

						item_stack = CurrencyStack.create(item, count)

					else:

						item_stack = ItemStack.create(item, count)

					loot.append(item_stack)

	return loot

