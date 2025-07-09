class_name StateManager
extends Manager

enum GameState {
	EXPLORE,
	COMBAT
}

@export var currentState: GameState = GameState.EXPLORE

@onready var logWindow: Log = get_node("/root/Explorer/Log")

func startCombat(encounter: Encounter):
	currentState = GameState.COMBAT
	logWindow.show()
	logWindow.warning("Combat Started!")
	combatManager.beginCombat(encounter)
