class_name Log
extends ExtendedWindow

@onready var richText: RichTextLabel = $"CanvasLayer/Control/Log RichText"

func warning(text: String):
	richText.push_bold()
	richText.append_text("[color=red]%s[/color]\n" % [text])
	richText.pop()

func attackText(action: QueuedAttack):
	richText.push_color(Color.LIGHT_GREEN)
	richText.append_text("%s_%s" % [action.originEntity.username, action.action.actionName])
	richText.pop()
	
	richText.append_text(" » ")
	
	richText.push_color(Color.INDIAN_RED)
	richText.append_text("[shake rate=25.0 level=15 connected=1]%s[/shake]\n" % [action.targetEntity.username])
	richText.pop()
