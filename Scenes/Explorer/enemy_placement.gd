class_name EnemyPlacement
extends Node3D

@export var daemon: Daemon
@onready var sprite: Sprite3D = $Sprite3D
@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var damageLabel: Label3D = $"Damage Label"
@onready var damageLabelAnim: AnimationPlayer = $"Damage Label/AnimationPlayer"

func _ready():
	sprite.texture = null

func showDamage(amount: int):
	damageLabel.text = str(amount)
	damageLabelAnim.play("damageNumber")

func updateDaemon(daemon: Daemon):
	daemon.lostHP.connect(showDamage)
	
	sprite.texture = daemon.sprite
	
	match daemon.temperment:
		0:
			animation.play("Calm")
		1:
			animation.play("Energetic")

	animation.speed_scale = randf_range(0.75, 1.5)

func kill():
	daemon = null
	sprite.texture = null
