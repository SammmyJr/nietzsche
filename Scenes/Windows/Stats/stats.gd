extends ExtendedWindow

@onready var background: Panel = $"CanvasLayer/Control/Status Background"
@onready var stylebox = background.get("theme_override_styles/panel") as StyleBoxFlat

var alpha = 0.5

var encounterLevelColours = [
	Color(Color.BLUE, alpha),
	Color(Color.GREEN, alpha),
	Color(Color.YELLOW, alpha),
	Color(Color.RED, alpha),
]

func _ready():
	super._ready()
	encounterManger.encounterStageChanged.connect(updateEncounterInfo)

func updateEncounterInfo():
	stylebox.bg_color = Color(encounterLevelColours[encounterManger.currentEncounterStage])
