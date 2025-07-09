extends Panel

@export var entity: EntityResource
@onready var nameLabel: Label = $"Status Name"
@onready var hpBar: ProgressBar = $"Slot Health"
@onready var spBar: ProgressBar = $"Slot Skill"
@onready var timeBar: ProgressBar = $"Slot Time"
@onready var button: Button = $Button

@onready var stateManager: StateManager = get_node("/root/Explorer/State Manager")

func _ready():
	nameLabel.text = entity.username
	
	# Hook into our entity's valueChanged signal to update details to be accurate
	entity.valueChanged.connect(updateDetails)
	
	updateDetails()

func _process(delta: float) -> void:
	timeBar.value = entity.currentActiveTime

func updateDetails():
	hpBar.value = entity.hp
	hpBar.max_value = entity.maxHP
	
	spBar.value = entity.sp
	spBar.max_value = entity.maxSP
