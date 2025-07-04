extends ExtendedWindow

func _on_start_combat_pressed() -> void:
	stateManger.startCombat()

func _on_end_combat_pressed() -> void:
	stateManger.endCombat()
