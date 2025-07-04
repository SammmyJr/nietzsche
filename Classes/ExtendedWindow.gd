class_name ExtendedWindow
extends Window

@export var startPositionOffset: Vector2i = Vector2i.ZERO
@onready var stateManger: StateManager = get_node("/root/Explorer/State Manager")
@onready var encounterManger: EncounterManager = get_node("/root/Explorer/Encounter Manager")


func _ready():
	get_window().position += startPositionOffset
