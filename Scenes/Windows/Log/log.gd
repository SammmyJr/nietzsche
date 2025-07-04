class_name Log
extends ExtendedWindow

@onready var richText: RichTextLabel = $"CanvasLayer/Control/Log RichText"

func warning(text: String):
	richText.push_bold()
	richText.append_text("[color=red]%s[/color]\n" % [text])
	richText.pop()
