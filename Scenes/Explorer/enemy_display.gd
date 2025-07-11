class_name EnemyDisplay
extends Control

@onready var combatManager: CombatManager = get_node("/root/Explorer/Combat Manager")
@onready var stateManager: StateManager = get_node("/root/Explorer/State Manager")

@onready var cursor: Sprite3D = $SubViewportContainer/SubViewport/Cursor
var cursorOffset := Vector3(0, 2, 0)

@onready var enemyContainer: Node3D = $"SubViewportContainer/SubViewport/Enemy Placements"
@onready var enemyPlacements := {}
@onready var placements := {}

# Works on a 3x2 grid system:
# (0, 1)    (1, 1)    (2, 1)
# (0, 0)    (1, 0)    (2, 0)
var currentSelectedPlacement: Vector2i = Vector2i(1, 0)

func _ready():
	# Default hide
	self.visible = false
	
	# Set up our possible cursor positions
	placements[Vector2i(0, 0)] = $"SubViewportContainer/SubViewport/Enemy Placements/Front Left"
	placements[Vector2i(1, 0)] = $"SubViewportContainer/SubViewport/Enemy Placements/Front Middle"
	placements[Vector2i(2, 0)] = $"SubViewportContainer/SubViewport/Enemy Placements/Front Right"
	placements[Vector2i(0, 1)] = $"SubViewportContainer/SubViewport/Enemy Placements/Back Left"
	placements[Vector2i(1, 1)] = $"SubViewportContainer/SubViewport/Enemy Placements/Back Middle"
	placements[Vector2i(2, 1)] = $"SubViewportContainer/SubViewport/Enemy Placements/Back Right"

func moveCursorBy(pos: Vector2i):
	var frontRowAmount = 0
	var backRowAmount = 0
	var oldPos = currentSelectedPlacement
	currentSelectedPlacement += pos
	
	for enemy in enemyPlacements:
		if enemy.y == 0:
			frontRowAmount += 1
		else:
			backRowAmount += 1

	# Clamp the new position first
	currentSelectedPlacement = Vector2i(clampi(currentSelectedPlacement.x, 0,  2), clampi(currentSelectedPlacement.y, 0, 1))
	
	combatManager.currentTarget = null
	
	# Check if there is an entity at that position
	if enemyPlacements.has(currentSelectedPlacement):
		# Change our current target in the CombatManager
		combatManager.changeTarget(enemyPlacements[currentSelectedPlacement])

	else: # Otherwise, we must be on a blank spot
		print(currentSelectedPlacement)
		#checkCursorPosition(oldPos, currentSelectedPlacement)
	
	# Then move the cursor to show selection
	cursor.position = placements[currentSelectedPlacement].position + cursorOffset

func checkCursorPosition(oldPos: Vector2i, nextPos: Vector2i):
	var frontRowAmount = 0
	var backRowAmount = 0
	# If we are on a blank spot, move left / right or up / down, depending on context
	
	for enemy in enemyPlacements:
		if enemy.y == 0:
			frontRowAmount += 1
		else:
			backRowAmount += 1

	# Check if we need to do anything first
	if !enemyPlacements.has(nextPos):
		# Then a space ahead, but check if we are going left or right
		if nextPos.x - oldPos.x < 0: # This is the going right condition
			# Can we actually jump across?
			if enemyPlacements.has(Vector2i(currentSelectedPlacement.x - 1, currentSelectedPlacement.y)):
				moveCursorBy(Vector2i(1, currentSelectedPlacement.y))
		elif nextPos.x - oldPos.x >= 0: # And going left condition
			if enemyPlacements.has(Vector2i(currentSelectedPlacement.x + 1, currentSelectedPlacement.y)):
				moveCursorBy(Vector2i(-1, currentSelectedPlacement.y))
		
		# If moving up into an empty space, move left or right
		if nextPos.y - oldPos.y < 0: # Going down
			pass
		elif nextPos.y - oldPos.y >= 0: # Going up
			pass

		# Check if we can go below or above us
		if enemyPlacements.has(Vector2i(nextPos.x, nextPos.y - 1)):
			moveCursorBy(Vector2i(0, -1))
		elif enemyPlacements.has(Vector2i(nextPos.x, nextPos.y + 1)):
			moveCursorBy(Vector2i(0, 1))
	else:
		currentSelectedPlacement = Vector2i.ZERO
		moveCursorBy(Vector2i(1, 0))

func _process(delta: float) -> void:
	if stateManager.currentState == 1:
		# New input method, move cursor relatively
		if Input.is_action_just_pressed("move_forward"):
			moveCursorBy(Vector2i(0, 1))
		if Input.is_action_just_pressed("move_backward"):
			moveCursorBy(Vector2i(0, -1))
		if Input.is_action_just_pressed("move_right"):
			moveCursorBy(Vector2i(1, 0))
		if Input.is_action_just_pressed("move_left"):
			moveCursorBy(Vector2i(-1, 0))
		
		# Old input method, 1:1 mapped with movement keys
		#if Input.is_action_just_pressed("move_left"):
			#selectAtPos(Vector2i(0, 0))
		#if Input.is_action_just_pressed("move_backward"):
			#selectAtPos(Vector2i(1, 0))
		#if Input.is_action_just_pressed("move_right"):
			#selectAtPos(Vector2i(2, 0))

		#if Input.is_action_just_pressed("look_left"):
			#selectAtPos(Vector2i(0, 1))
		#if Input.is_action_just_pressed("move_forward"):
			#selectAtPos(Vector2i(1, 1))
		#if Input.is_action_just_pressed("look_right"):
			#selectAtPos(Vector2i(2, 1))

func resetCursor():
	currentSelectedPlacement = Vector2i(1, 0)
	moveCursorBy(Vector2i(0,0))

func removeEnemy(entity: EntityResource):
	for pos in enemyPlacements:
		if enemyPlacements[pos] == entity:
			placements[pos].kill()
			enemyPlacements.erase(pos)

func resetEnemies():
	for pos in enemyPlacements:
		print("Killing %s" % [enemyPlacements[pos]])
		placements[pos].kill()
		enemyPlacements.erase(pos)

func registerEnemy(entity: EntityResource):
	var gridPos = Vector2i(randi_range(0,2), randi_range(0,1))
	if !enemyPlacements.has(gridPos):
		if enemyPlacements.size() < 1: # If its the first entity, place it front & centre
			gridPos = Vector2i(1,0)
			enemyPlacements[gridPos] = entity
			placements[gridPos].updateDaemon(entity)
		else:
			enemyPlacements[gridPos] = entity
			placements[gridPos].updateDaemon(entity)
	else:
		registerEnemy(entity)
