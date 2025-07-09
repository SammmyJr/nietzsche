class_name QueuedAttack
extends QueuedAction

@export var action: SkillResource
@export var originEntity: EntityResource
@export var targetEntity: EntityResource

func _init(p_action, p_originEntity, p_targetEntity) -> void:
	action = p_action
	originEntity = p_originEntity
	targetEntity = p_targetEntity
