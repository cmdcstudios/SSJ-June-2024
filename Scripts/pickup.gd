extends Node2D

@export var item:Item
@export var item_tooltip: PackedScene

@onready var area_2d: Area2D = %Area2D

var _tooltip: Tooltip = null

func _ready() -> void:
	var sprite_texture = item.inventory_icon
	var sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	add_child(sprite)
	SignalManager.item_sold.connect(_on_item_sold)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if _tooltip == null && TooltipInfo.tooltips.size() == 0:
		_tooltip = item_tooltip.instantiate() as Tooltip
		TooltipInfo.tooltips.append(_tooltip)
		_tooltip.load_item_info(item)
		await get_tree().create_timer(0.35).timeout
		self.add_child(_tooltip)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("inventory_button_click")):
		if (TooltipInfo.tooltips.size() >= 1):
			TooltipInfo.tooltips[0].queue_free()
			TooltipInfo.tooltips.pop_front()
			_tooltip = item_tooltip.instantiate() as Tooltip
			TooltipInfo.tooltips.append(_tooltip)
			_tooltip.load_item_info(item)
			self.add_child(_tooltip)

		var player = area_2d.get_overlapping_areas()[0].get_parent() as Player
		if player.has_method("on_item_pickup"):
			player.on_item_pickup(item)

func _on_item_sold(money_amount: int, item_sold: Item) -> void:
	if item == item_sold:
		queue_free()
