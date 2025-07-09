class_name ActionResource
extends Resource

enum actionTypeEnum {
	ACTION,
	ATTACK,
	SUPPORT,
}

@export var actionName: String = "New Action"
@export var actionType: actionTypeEnum = 0
