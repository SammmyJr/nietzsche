class_name EntityResource
extends Resource

signal valueChanged
signal gainedHP(hpGained)
signal lostHP(hpLost)

@export var username: String = "Bob"
@export var sprite: CompressedTexture2D = preload("res://icon.svg")

@export var hp: int = 10:
	set(value):
		if value >= hp:
			emit_signal("gainedHP", value - hp)
		else:
			emit_signal("lostHP", hp - value)
		hp = value
@export var sp: int = 5
@export var maxHP: int = 10
@export var maxSP: int = 5

@export var speed: float = 1
var currentActiveTime: float = 0:
	set(value):
		currentActiveTime = value
		valueChanged.emit()

@export var skills: Array[SkillResource] = []
