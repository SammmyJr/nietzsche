extends Control

@onready var richText: RichTextLabel = $Dialog/RichTextLabel

var dialog := [
	[
		"Hello there!",
		"So you wanna try out the [b]combat sim[/b], huh?",
		"Alright! Let's get you started then.",
	],
	[
		"Hello Again!"
	]
]

var currentDialogIndex = 0
var currentSectionIndex = 0
var textSpeed = 0.25

func _ready():
	advanceText()
	
func _process(delta: float) -> void:
	if richText.visible_ratio < 1.0:
		richText.visible_ratio += textSpeed / dialog[currentSectionIndex][currentDialogIndex - 1].length()

	if Input.is_action_just_pressed("dialog_next"):
		advanceText()

func advanceText():
	if currentDialogIndex >= dialog[currentSectionIndex].size():
		currentSectionIndex += 1
		currentDialogIndex = 0

	richText.text = dialog[currentSectionIndex][currentDialogIndex]
	richText.visible_ratio = 0.0
	currentDialogIndex += 1
