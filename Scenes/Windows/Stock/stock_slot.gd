class_name StockSlot
extends Control

@export var daemon: Daemon

@onready var nameLabel: Label = $"Slot Name"
@onready var hpBar: ProgressBar = $"Slot Health"
@onready var spBar: ProgressBar = $"Slot Skill"

func _ready():
	updateDetails()
	
func updateDetails():
	nameLabel.text = daemon.username
	
	hpBar.value = daemon.hp
	hpBar.max_value = daemon.maxHP
	
	spBar.value = daemon.sp
	spBar.max_value = daemon.maxSP
