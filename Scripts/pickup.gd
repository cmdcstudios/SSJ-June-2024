extends Node2D

@export var item:Item
@onready var area_2d: Area2D = %Area2D

func _ready() -> void:
	var sprite_texture = item.inventory_icon
	var sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	add_child(sprite)

func _on_area_2d_area_entered(area: Area2D) -> void:
	# Instance the tooltip here
	print(item.name)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("inventory_button_click")):
		var player = area_2d.get_overlapping_areas()[0].get_parent() as Player
		if player.has_method("on_item_pickup"):
			player.on_item_pickup(item)
	pass # Replace with function body.
