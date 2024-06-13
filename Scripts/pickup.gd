extends Node2D

@export var item:Item
@export var item_tooltip: PackedScene

@onready var area_2d: Area2D = %Area2D

var _is_tooltip_open: bool = false

func _ready() -> void:
	var sprite_texture = item.inventory_icon
	var sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	add_child(sprite)

#func load_item_info(tooltip: PackedScene, item: Item):
	#

func _on_area_2d_area_entered(area: Area2D) -> void:
		if !_is_tooltip_open:
			var tooltip = item_tooltip.instantiate() as Tooltip
			tooltip.load_item_info(item)
			await get_tree().create_timer(0.35).timeout
			self.add_child(tooltip)
			toggle_tooltip()

func toggle_tooltip() -> void:
	_is_tooltip_open = !_is_tooltip_open


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("inventory_button_click")):
		var player = area_2d.get_overlapping_areas()[0].get_parent() as Player
		if player.has_method("on_item_pickup"):
			player.on_item_pickup(item)


