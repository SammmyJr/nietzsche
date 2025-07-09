class_name ExtendedWindow
extends Window

@export var startPositionOffset: Vector2i = Vector2i.ZERO
@export_enum("Middle", "Top Left", "Bottom Right", "Middle Bottom") var anchorPoint = 0
@export var windowScaleFactor: float = 1.0

@onready var stateManger: StateManager = get_node("/root/Explorer/State Manager")
@onready var encounterManger: EncounterManager = get_node("/root/Explorer/Encounter Manager")
@onready var combatManger: CombatManager = get_node("/root/Explorer/Combat Manager")
@onready var player: Player = get_node("/root/Explorer/Player")

var anchors = []

func resetPosition():
	var anchors = [ # These are relative to the centre of the primary window
		Vector2i.ZERO, # Middle
		DisplayServer.screen_get_size(DisplayServer.get_primary_screen()) / 2 - (get_window().size / 2), # Top Left
		-DisplayServer.screen_get_size(DisplayServer.get_primary_screen()) / 2 + (get_window().size / 2), # Bottom Right
		Vector2i(0, -DisplayServer.screen_get_size(DisplayServer.get_primary_screen()).y / 2 + get_window().size.y / 2), # Bottom Middle
	]

	get_window().position += startPositionOffset - anchors[anchorPoint]

func _ready():
	resetPosition()
	
	get_window().content_scale_factor = windowScaleFactor
	get_window().size = get_window().size * windowScaleFactor
	
	self.visibility_changed.connect(resetPosition)
	
	get_window().close_requested.connect(self.hide)
