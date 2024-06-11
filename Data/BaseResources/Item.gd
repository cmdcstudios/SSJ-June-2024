class_name Item
extends Resource

@export var id: int
@export var sell_price: int
@export var name: String
@export var description: String
@export var item_attributes: Array[ItemAttribute]
@export var inventory_icon: Texture2D
@export var scene: PackedScene
#@export var resource: Resource
