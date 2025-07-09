extends ExtendedWindow

@onready var currencyRichText: RichTextLabel = $"CanvasLayer/Control/Currency RichText"

func _ready():
	super._ready()
	updateCurrency()
	
	player.stats.currencyChanged.connect(updateCurrency)

func updateCurrency():
	currencyRichText.clear()
	currencyRichText.append_text("Dollars: $%s\n" % player.stats.money)
	currencyRichText.append_text("Hexbytes: ₿%s\n" % player.stats.hexbytes)
