class_name EncounterManager
extends Manager

signal encounterStageChanged

@export var defaultEncounter: Encounter

@export var encounterRate: float = 0.5 # Chance for likelyhood of encounters to go up based on each step
var currentEncounterStage = 1
	# 0 ~ Safe
	# 1 ~ Low
	# 2 ~ Medium
	# 3 ~ High

func _ready():
	#super()._ready()
	player.stepTaken.connect(rollEncounter)

func rollEncounter():
	if currentEncounterStage > 0: #Check if encounters are allowed
		if randf_range(0, 1.0) <= encounterRate:
			if currentEncounterStage >= 3:
				stateManager.startCombat(defaultEncounter)
				currentEncounterStage = 1
			else:
				currentEncounterStage += 1
				encounterStageChanged.emit()
