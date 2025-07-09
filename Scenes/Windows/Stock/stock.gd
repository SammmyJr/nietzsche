extends ExtendedWindow

@onready var playerStats: PlayerStats
@onready var slots: VBoxContainer = $CanvasLayer/Control/Slots
@onready var slotTemplate: PackedScene = preload("res://Scenes/Windows/Stock/stock_slot.tscn")

func _ready():
	super._ready()

	playerStats = player.stats
	updateDetails()

func updateDetails():
	for daemon in playerStats.stock:
		var template: StockSlot = slotTemplate.instantiate()
		template.daemon = daemon
		slots.add_child(template)
