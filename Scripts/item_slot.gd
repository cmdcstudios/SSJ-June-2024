extends PanelContainer

@export var item_tooltip: PackedScene
@export var item: Item
@onready var texture_rect: TextureButton = %TextureRect


var _tooltip: Tooltip = null #tooltip
var _stored_item: Item = null #godot item

signal slot_sold

func _ready() -> void:
	_stored_item = item
	
func display_item(inv_item:Item):
	_stored_item = inv_item
	texture_rect.texture_normal = inv_item.inventory_icon

func _on_texture_rect_mouse_entered() -> void:
	# We are assuming we are in sell mode:
		# Insantiate a tooltip if one doesn't exist and one is not in the tracking array	
	if _tooltip == null && TooltipInfo.tooltips.size() == 0:
		if (GameManager.current_game_state == GameManager.GameFlags.SELLABLE):	
			_tooltip = item_tooltip.instantiate() as Tooltip
			TooltipInfo.tooltips.append(_tooltip)
			_tooltip.load_item_info(_stored_item)
			if (_stored_item.id == 3):
				_tooltip.load_item_info(item)
			await get_tree().create_timer(0.35).timeout
			self.get_parent().add_child(_tooltip)
			if (!SignalManager.item_sold.is_connected(_on_item_sold)):
				print("Tooltip connected!")
				SignalManager.item_sold.connect(_on_item_sold)
		if (GameManager.current_game_state == GameManager.GameFlags.NORMAL and _stored_item.id != 3):
			_tooltip = item_tooltip.instantiate() as Tooltip
			TooltipInfo.tooltips.append(_tooltip)
			_tooltip.load_item_info(_stored_item) # default item slot item
			await get_tree().create_timer(0.35).timeout
			self.get_parent().add_child(_tooltip)
			##_stored_item = item
			if (!SignalManager.item_sold.is_connected(_on_item_sold)):
				print("Tooltip connected!")
				SignalManager.item_sold.connect(_on_item_sold)

func _on_texture_rect_pressed() -> void:
	if GameManager.current_game_state == GameManager.GameFlags.NORMAL and _stored_item.id != 3:
		if (TooltipInfo.tooltips.size() >= 1):
			TooltipInfo.tooltips[0].queue_free()
			TooltipInfo.tooltips.pop_front()
			_tooltip = item_tooltip.instantiate() as Tooltip
			TooltipInfo.tooltips.append(_tooltip)
			_tooltip.load_item_info(_stored_item)
			self.add_child(_tooltip)
	if GameManager.current_game_state == GameManager.GameFlags.SELLABLE: 
		if (TooltipInfo.tooltips.size() >= 1):
			TooltipInfo.tooltips[0].queue_free()
			TooltipInfo.tooltips.pop_front()
			_tooltip = item_tooltip.instantiate() as Tooltip
			TooltipInfo.tooltips.append(_tooltip)
			_tooltip.load_item_info(_stored_item)
			self.add_child(_tooltip)





func _on_item_sold(money_amount: int, item_sold: Item) -> void:
	if (_stored_item.id == 3 and item_sold == item):
		print("item sold: " + item.name)
		slot_sold.emit()
		queue_free()
	else: 
		#print("item sold: " + _stored_item.name)
		_stored_item = item
		texture_rect.texture_normal = item.inventory_icon






