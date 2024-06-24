class_name SellableItem
extends Node2D

@export var item: Item
@export var item_tooltip: PackedScene
@onready var area_3d = $Area3D

var _tooltip: Tooltip = null

func spawn_tooltip(ui_root: CanvasLayer):
	SignalManager.tooltip_closed.emit()
	if GameManager.current_game_state == GameManager.GameFlags.SELLABLE: 
		if (_tooltip == null or TooltipInfo.tooltips.size() >= 1):
			if TooltipInfo.tooltips.size() > 0: TooltipInfo.tooltips[0].queue_free()
			TooltipInfo.tooltips.pop_front()
			_tooltip = item_tooltip.instantiate() as Tooltip
			#_tooltip.get_child(0).global_position = global_position + Vector2(800, 0)
			TooltipInfo.tooltips.append(_tooltip)
			_tooltip.load_item_info(item)
			if (!SignalManager.item_sold.is_connected(_on_item_sold)):
				print("Tooltip connected!")
				SignalManager.item_sold.connect(_on_item_sold)
			#_tooltip.load_item_info(_stored_item)
			ui_root.add_child(_tooltip)# Replace with function body.
			
func _on_item_sold(money_amount: int, item_sold: Item) -> void:
	get_parent().queue_free()
	print("sold!")
