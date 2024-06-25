extends CanvasLayer
@onready var the_tool_tip: TextureButton = $TheToolTip

const TOOLTIP_ITSELF = preload("res://Data/Items/71_tooltip_itself.tres") as Item
# The game will end and some dialogue will need to play afterwards. 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	the_tool_tip.hide()
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/ending_dialogue.dialogue"), "sold_the_game")

func _on_the_tool_tip_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/final.dialogue"), "start")

func _on_dialogue_ended():
	the_tool_tip.show()
