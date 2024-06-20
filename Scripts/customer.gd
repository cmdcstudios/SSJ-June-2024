class_name Customer
extends Node2D

@export var item_preference : Array[ItemAttribute]
@export var sprite_texture : Texture2D
@export var customer_name : String
@export var customer_greeting : String
@export var customer_dialogue : DialogueResource

@onready var preference_box = $CustomerSprite/PreferenceBox
@onready var customer_sprite = $CustomerSprite
@onready var name_label = $CustomerSprite/NameLabel
var preference_sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	customer_sprite.texture = sprite_texture
	name_label.text = customer_name
	for n in item_preference:
		var new_preference :=  TextureRect.new()
		new_preference.texture = n.attribute_icon
		preference_box.add_child(new_preference)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
