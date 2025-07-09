extends ExtendedWindow

@export var windows: Array[ExtendedWindow]
@onready var dock: HBoxContainer = $"CanvasLayer/Control/Dock Windows"
@onready var appTemplate: PackedScene = preload("res://Scenes/Windows/Dock/icon.tscn")

func _ready():
	super._ready()
	
	get_window().show()
	
	for window in windows:
		var app: App = appTemplate.instantiate()
		app.window = window
		app.text = window.title
		dock.add_child(app)
