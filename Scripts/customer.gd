extends Node2D

@export var item_preference : ItemAttribute

var preference_sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	preference_sprite = $CustomerSprite/PreferenceSprite
	preference_sprite.texture = item_preference.attribute_icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
