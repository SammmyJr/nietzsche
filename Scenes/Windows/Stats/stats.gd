extends ExtendedWindow

@onready var background: Panel = $"CanvasLayer/Control/Status Background"
@onready var label: Label = $"CanvasLayer/Control/Status Label"
@onready var stylebox = background.get("theme_override_styles/panel") as StyleBoxFlat

@onready var stockList: VBoxContainer = $CanvasLayer/Control/Control/VBoxContainer
@onready var stockBoxTemplate: PackedScene = preload("res://Scenes/Windows/Stats/status_box_top.tscn")

@onready var actionList: VBoxContainer = $"CanvasLayer/Control/Control2/Action Background/Action Container"
@onready var actionBoxTemplate: PackedScene = preload("res://Scenes/Windows/Stats/action_box.tscn")

var alpha = 0.5

var encounterLevelColours = [
	Color(Color.GREEN, alpha),
	Color(Color.BLUE, alpha),
	Color(Color.YELLOW, alpha),
	Color(Color.RED, alpha),
]

var encounterLevelText = [
	"N/A",
	"Safe",
	"Caution",
	"Danger",
]

func _ready():
	super._ready()
	
	# Hook into the encounterManager as to change status bar colour on encounter rate change
	encounterManger.encounterStageChanged.connect(updateEncounterInfo)
	
	# Hook into our Player class and update status when things change
	player.stockUpdated.connect(updateStockListInfo)
	
	# Refresh the current status of everything & encounter risk
	updateStockListInfo()
	updateEncounterInfo()

# Change the colour of the status bar to match with encounter chance
func updateEncounterInfo():
	stylebox.bg_color = Color(encounterLevelColours[encounterManger.currentEncounterStage])
	label.text = encounterLevelText[encounterManger.currentEncounterStage]

# Literally just add all daemon in active stock to the status panel via a template
func updateStockListInfo():
	# Clear other daemons first, then repopulate
	for oldDaemon in stockList.get_children():
		stockList.remove_child(oldDaemon)
		oldDaemon.queue_free()
	
	addEntityToStatus(player.stats)
		
	for daemon in player.stats.activeStock:
		addEntityToStatus(daemon)

# This handles the creation and information of the template
func addEntityToStatus(entity: EntityResource):
	var box = stockBoxTemplate.instantiate()
	box.entity = entity
	stockList.add_child(box)
	box.button.pressed.connect(Callable(self, "listSkills").bind(entity))

# Change the list of skills relative to the currently selected daemon in active stock
func listSkills(entity: EntityResource):
	# Clear other actions first, then repopulate
	for oldAction in actionList.get_children():
		actionList.remove_child(oldAction)
		oldAction.queue_free()
	for skill in entity.skills:
		var actionButton = actionBoxTemplate.instantiate() as ActionButton
		
		actionButton.skill = skill
		
		actionList.add_child(actionButton)
		
		# Hook up the skill button to the combatManager's queue action function
		actionButton.pressed.connect(Callable(combatManger, "queueAction").bind(skill, entity))
