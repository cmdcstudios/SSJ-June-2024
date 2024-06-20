class_name ItemAttribute
extends Resource

enum Attribute {
	PLAIN,
	COOL,
	SOLID,
	CUTE,
	FLASHY,
	CURIOUS,
	STRANGE,
	MAGICAL,
	NASTY
}

@export var name : String
@export var attribute_type: Attribute = Attribute.PLAIN
@export var attribute_icon: Texture2D

