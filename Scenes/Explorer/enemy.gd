extends Control

@onready var nameLabel: Label = $"VBoxContainer/Enemy Name"
@onready var button: Button = $"Enemy Select"
@onready var text: RichTextLabel = $"Enemy Text"

@export var daemon: Daemon = preload("res://Daemons/Testy.tres")

func _ready():
	nameLabel.text = daemon.username
	
	daemon.lostHP.connect(hurtText)

func hurtText(amount: int):
	text.push_color(Color.RED)
	text.append_text("[shake rate=25.0 level=15 connected=1]%s[/shake]" % [amount])
	text.pop_all()
	
	await get_tree().create_timer(1.0).timeout
	
	text.clear()
