class_name App
extends Button

@export var window: ExtendedWindow

func _ready():
	self.pressed.connect(toggleWindow)

func toggleWindow():
	if window.visible:
		window.hide()
	else:
		window.show()
