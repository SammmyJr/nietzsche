extends Node3D

@onready var area: Area3D = $Area3D
@onready var stateManager: StateManager = get_node("/root/Explorer/State Manager")

@export var encounter: Encounter

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		stateManager.startCombat(encounter)
