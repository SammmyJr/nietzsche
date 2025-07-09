class_name Manager
extends Node

@onready var player: Player = get_node("/root/Explorer/Player")
@onready var stateManager: StateManager = get_node("/root/Explorer/State Manager")
@onready var enounterManager: EncounterManager = get_node("/root/Explorer/Encounter Manager")
@onready var combatManager: CombatManager = get_node("/root/Explorer/Combat Manager")
@onready var musicManager: MusicManager = get_node("/root/Explorer/Music Manager")
@onready var enemyDisplay: EnemyDisplay = get_node("/root/Explorer/Enemy Display")

@onready var log: Log = get_node("/root/Explorer/Log")
