extends Node2D

@export var item_preference : ItemAttribute

@onready var preference_sprite = $CustomerSprite/PreferenceSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	preference_sprite.texture = item_preference.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
