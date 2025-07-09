class_name ActionButton
extends Button

@export var skill: SkillResource

func _ready():
	self.text = skill.actionName
