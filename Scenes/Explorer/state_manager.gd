class_name StateManager
extends Manager

enum GameState {
	EXPLORE,
	COMBAT
}

@export var currentState: GameState = GameState.EXPLORE

@onready var logWindow: Log = get_node("/root/Explorer/Log")

func startCombat():
	logWindow.warning("Combat Started!")
	currentState = GameState.COMBAT
	
func endCombat():
	logWindow.warning("Combat Ended!")
	
	currentState = GameState.EXPLORE
