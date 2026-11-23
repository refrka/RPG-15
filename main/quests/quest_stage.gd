class_name QuestStage extends Resource



signal objective_completed(objective: QuestObjective)




@export var objectives: Array[QuestObjective] 





func initialize(quest_data: QuestData) -> void:

	for objective in objectives:

		objective.initialize(quest_data)

		objective.completed.connect(_on_objective_completed.bind(objective))




func _on_objective_completed(objective: QuestObjective) -> void:	

	objective_completed.emit(objective)