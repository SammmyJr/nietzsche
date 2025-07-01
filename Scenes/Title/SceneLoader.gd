extends Button

@export var scene: PackedScene

func loadScene():
	get_tree().change_scene_to_packed(scene)
