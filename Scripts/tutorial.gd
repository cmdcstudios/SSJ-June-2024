extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/tutorial_dialogue.dialogue"), "start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
