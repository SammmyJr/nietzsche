class_name CombatManager
extends Manager

var currentEncounters: Array[EntityResource] = []
@export var turnStack: Array[QueuedAction] = []

var currentTarget: Daemon
var processingAction: bool = false

func _process(delta: float) -> void:
	# Uptick player & summons active time when in combat
	if stateManager.currentState == 1:
		for daemon in player.stats.activeStock:
			if daemon.currentActiveTime < 100:
				daemon.currentActiveTime += daemon.speed
		
		player.stats.currentActiveTime += player.stats.speed

func beginCombat(encounter: Encounter):
	# Create a local list of our encounters
	for daemon in encounter.possibleEnemies:
		currentEncounters.append(daemon.duplicate())
	
	# Change the music
	musicManager.changeMusic(1)
	
	# Register our enemies to the display
	updateCurrentEncountersList()
	
	# Make the display visible
	enemyDisplay.visible = true

func endCombat():
	stateManager.logWindow.warning("Combat Ended!")
	stateManager.logWindow.hide()
	
	stateManager.currentState = 0
	enounterManager.currentEncounterStage = 1
	enounterManager.encounterStageChanged.emit()
	
	# Set our music back to the background theme
	musicManager.changeMusic(0)
	
	# Reset the log text
	log.richText.clear()
	
	# Set all activeTime back to 0
	player.stats.currentActiveTime = 0
	for entity in player.stats.activeStock:
		entity.currentActiveTime = 0
	
	# Hide the enemy display
	enemyDisplay.visible = false


func updateCurrentEncountersList():
	# Display current encounter and hook up targeting logic
	for daemon in currentEncounters:
		enemyDisplay.registerEnemy(daemon)

func changeTarget(target: Daemon):
	if target in currentEncounters: # Check if the target is still valid
		currentTarget = target
		print("Current target is %s at %shp" % [currentTarget.username, currentTarget.hp])

# Add an action to the queue, then check if another action on the queue needs to resolve
func queueAction(action: ActionResource, origin: EntityResource):
	if action is SkillResource:
		turnStack.append(QueuedAttack.new(action, origin, currentTarget))

	if turnStack.size() == 1:
		executeAction(turnStack[0])

# Execute an action from an entity, firstly we need to check:
# - Can the entity execute this action? (activeTime, SP, etc.)
# - Is it targeting itself?
func executeAction(queuedAction: QueuedAction):
	# Check type of action being executed, then act accordingly
	if queuedAction is QueuedAttack:
		var attack = queuedAction as QueuedAttack
		var origin = attack.originEntity
		var target = attack.targetEntity
		var currentSkill = attack.action as SkillResource

		if origin.currentActiveTime >= 100 and origin.sp >= currentSkill.spCost and target != null:
			# Add a log entry
			log.attackText(attack)
			
			# Deal damage to the encounter entity
			target.hp -= currentSkill.damage
			
			# Take away SP
			origin.sp -= currentSkill.spCost
			
			# Wait a second for combat text / effects
			await get_tree().create_timer(1.0).timeout
			
			# Reset activeTime
			origin.currentActiveTime = 0
			
			# Check if entity is dead, if so remove it from the current encounters
			if target.hp <= 0:
				currentEncounters.erase(target)
				enemyDisplay.removeEnemy(target)
			
			if currentEncounters.size() <= 0: # If there is nothing left to fight, end combat
				endCombat()
	
	# Check if other actions also need to be executed
	if turnStack.size() > 0:
		executeAction(turnStack.pop_front())
	
