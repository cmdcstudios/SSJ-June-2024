extends Node2D

@export var item:Item

func _ready() -> void:
	var sprite_texture = item.inventory_icon
	var sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	add_child(sprite)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var player = area.get_parent() as Player
	if (player.has_method("on_item_pickup")):
		player.on_item_pickup(item)
