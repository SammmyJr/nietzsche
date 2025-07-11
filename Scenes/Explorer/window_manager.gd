extends Manager

func _ready():
	# Resize our window to fit with whats specified in optios
	get_window().content_scale_factor = player.stats.options.windowScale
	get_window().size = get_window().size * player.stats.options.windowScale
	
	get_window().position = DisplayServer.screen_get_size(DisplayServer.get_primary_screen()) / 2 - (get_window().size / 2)
