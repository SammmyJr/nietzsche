class_name EnemyPlacement
extends Node3D

@export var daemon: Daemon
@onready var sprite: Sprite3D = $Sprite3D

func updateDaemon(daemon: Daemon):
	sprite.texture = daemon.sprite

func kill():
	daemon = null
	sprite.texture = null
