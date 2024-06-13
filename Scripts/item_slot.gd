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
		if _stored_item != null:
			_tooltip.load_item_info(_stored_item)
		_tooltip.load_item_info(item)
		_stored_item = item
		await get_tree().create_timer(0.35).timeout
		self.get_parent().add_child(_tooltip)
		_tooltip.item_sold.connect(_on_item_sold)
		
func _on_item_sold() -> void:
	slot_sold.emit()
	print("GODDAMN I SoLD IT")
	queue_free()
	
