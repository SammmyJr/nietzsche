extends summoningWindow

@onready var entryRichText: RichTextLabel = $"CanvasLayer/Control/Entry/Entry Rich Text"

@onready var button7: Button = $"CanvasLayer/Control/Keypad/Left/7"
@onready var button4: Button = $"CanvasLayer/Control/Keypad/Left/4"
@onready var button1: Button = $"CanvasLayer/Control/Keypad/Left/1"
@onready var button8: Button = $"CanvasLayer/Control/Keypad/Middle/8"
@onready var button5: Button = $"CanvasLayer/Control/Keypad/Middle/5"
@onready var button2: Button = $"CanvasLayer/Control/Keypad/Middle/2"
@onready var button0: Button = $"CanvasLayer/Control/Keypad/Middle/0"
@onready var button9: Button = $"CanvasLayer/Control/Keypad/Right/9"
@onready var button6: Button = $"CanvasLayer/Control/Keypad/Right/6"
@onready var button3: Button = $"CanvasLayer/Control/Keypad/Right/3"

@onready var clearButton: Button = $"CanvasLayer/Control/Keypad/Left/Clear"
@onready var okButton: Button = $"CanvasLayer/Control/Keypad/Right/Enter"

var currentEntry: String = ""

func _ready():
	super._ready()
	
	button1.pressed.connect(Callable(self, "appendEntry").bind("1"))
	button2.pressed.connect(Callable(self, "appendEntry").bind("2"))
	button3.pressed.connect(Callable(self, "appendEntry").bind("3"))
	button4.pressed.connect(Callable(self, "appendEntry").bind("4"))
	button5.pressed.connect(Callable(self, "appendEntry").bind("5"))
	button6.pressed.connect(Callable(self, "appendEntry").bind("6"))
	button7.pressed.connect(Callable(self, "appendEntry").bind("7"))
	button8.pressed.connect(Callable(self, "appendEntry").bind("8"))
	button9.pressed.connect(Callable(self, "appendEntry").bind("9"))
	button0.pressed.connect(Callable(self, "appendEntry").bind("0"))
	
	clearButton.pressed.connect(clearEntry)
	okButton.pressed.connect(checkEntry)
	
	clearEntry()
	
func appendEntry(entry: String):
	currentEntry += entry
	entryRichText.append_text(entry)
	
func clearEntry():
	currentEntry = ""
	entryRichText.text = ""

func checkEntry():
	for daemon in player.stats.stock:
		if currentEntry == daemon.id:
			summon(daemon)
