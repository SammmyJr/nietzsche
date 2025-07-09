class_name EnemyDisplay
extends Control

@onready var combatManager: CombatManager = get_node("/root/Explorer/Combat Manager")
@onready var stateManager: StateManager = get_node("/root/Explorer/State Manager")

@onready var cursor: Sprite3D = $SubViewportContainer/SubViewport/Cursor
var cursorOffset := Vector3(0, 0.75, 0)

@onready var enemyContainer: Node3D = $"SubViewportContainer/SubViewport/Enemy Placements"
@onready var enemyPlacements := {}
@onready var placements := {}

# Works on a 3x2 grid system:
# (0, 1)    (1, 1)    (2, 1)
# (0, 0)    (1, 0)    (2, 0)
var currentSelectedPlacement: Vector2i = Vector2i.ZERO

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

func selectAtPos(pos: Vector2i):
	# Check if there is an entity at that position
	if enemyPlacements.has(pos):
		print(enemyPlacements[pos].username)
		combatManager.changeTarget(enemyPlacements[pos])
		
		# Then move the cursor to show selection
		cursor.position = placements[pos].position + cursorOffset

func _process(delta: float) -> void:
	if stateManager.currentState == 1:
		if Input.is_action_just_pressed("move_left"):
			selectAtPos(Vector2i(0, 0))
		if Input.is_action_just_pressed("move_backward"):
			selectAtPos(Vector2i(1, 0))
		if Input.is_action_just_pressed("move_right"):
			selectAtPos(Vector2i(2, 0))
			
		if Input.is_action_just_pressed("look_left"):
			selectAtPos(Vector2i(0, 1))
		if Input.is_action_just_pressed("move_forward"):
			selectAtPos(Vector2i(1, 1))
		if Input.is_action_just_pressed("look_right"):
			selectAtPos(Vector2i(2, 1))

func removeEnemy(entity: EntityResource):
	for pos in enemyPlacements:
		if enemyPlacements[pos] == entity:
			placements[pos].kill()
			enemyPlacements.erase(pos)

func registerEnemy(entity: EntityResource):
	var gridPos = Vector2i(randi_range(0,2), randi_range(0,1))
	if !enemyPlacements.has(gridPos):
		enemyPlacements[gridPos] = entity
		placements[gridPos].updateDaemon(entity)
	else:
		registerEnemy(entity)
	print(enemyPlacements)
