class_name Customer
extends Node2D

@export var item_preference : Array[ItemAttribute]
@onready var preference_box = $CustomerSprite/PreferenceBox
var preference_sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	for n in item_preference:
		var new_preference :=  TextureRect.new()
		new_preference.texture = n.attribute_icon
		preference_box.add_child(new_preference)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
