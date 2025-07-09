extends ExtendedWindow
 
@export var defaultEncounter: Encounter

func _on_start_combat_pressed() -> void:
	print(defaultEncounter)
	print(defaultEncounter.possibleEnemies)
	stateManger.startCombat(defaultEncounter)

func _on_end_combat_pressed() -> void:
	combatManger.endCombat()
