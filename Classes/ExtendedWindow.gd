class_name ExtendedWindow
extends Window

@export var startPositionOffset: Vector2i = Vector2i.ZERO
@export var windowScaleFactor: float = 1.0

@onready var stateManger: StateManager = get_node("/root/Explorer/State Manager")
@onready var encounterManger: EncounterManager = get_node("/root/Explorer/Encounter Manager")


func _ready():
	get_window().position += startPositionOffset
	get_window().content_scale_factor = windowScaleFactor
	get_window().size = get_window().size * windowScaleFactor
