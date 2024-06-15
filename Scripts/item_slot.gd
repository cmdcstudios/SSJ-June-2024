extends PanelContainer

@export var item_tooltip: PackedScene
@export var item: Item
@onready var texture_rect: TextureRect = %TextureRect

var _tooltip: Tooltip = null
var _stored_item: Item = null

signal slot_sold

func display_item(item:Item):
	_stored_item = item
	texture_rect.texture = item.inventory_icon

func _on_texture_rect_mouse_entered() -> void:
	if _tooltip == null && TooltipInfo.tooltips.size() == 0:
		_tooltip = item_tooltip.instantiate() as Tooltip
		TooltipInfo.tooltips.append(_tooltip)
		_tooltip.load_item_info(item)
		if _stored_item != null:
			_tooltip.load_item_info(_stored_item)
		#_tooltip.load_item_info(item)
		#_stored_item = item
		await get_tree().create_timer(0.35).timeout
		self.get_parent().add_child(_tooltip)
		if (!SignalManager.item_sold.is_connected(_on_item_sold)):
			SignalManager.item_sold.connect(_on_item_sold)

func _on_item_sold(money_amount: int, item_sold: Item) -> void:
	if (_stored_item == null):
		print("item sold: " + item.name)
		slot_sold.emit()
		queue_free()
	else: 
		_stored_item = null
		texture_rect.texture = item.inventory_icon


