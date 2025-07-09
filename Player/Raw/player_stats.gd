class_name PlayerStats
extends EntityResource

signal currencyChanged

@export var activeStock: Array[Daemon] = []
@export var stock: Array[Daemon] = []

@export var money: int = 100:
	set(value):
		money = value
		currencyChanged.emit()
@export var hexbytes: int = 50:
	set(value):
			hexbytes = value
			currencyChanged.emit()
