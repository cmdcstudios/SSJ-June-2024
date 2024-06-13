extends PanelContainer

@export var item_tooltip: PackedScene
@export var item: Item
@onready var texture_rect: TextureRect = %TextureRect
var _is_tooltip_open: bool = false
var stored_item: Item = null

func display_item(item:Item):
	stored_item = item
	texture_rect.texture = item.inventory_icon

func toggle_tooltip() -> void:
	_is_tooltip_open = !_is_tooltip_open

#
func _on_texture_rect_mouse_entered() -> void:
	print(stored_item)
	if !_is_tooltip_open:
		var tooltip = item_tooltip.instantiate() as Tooltip
		if stored_item != null:
			tooltip.load_item_info(stored_item)
		tooltip.load_item_info(item)
		await get_tree().create_timer(0.35).timeout
		self.get_parent().add_child(tooltip)
		toggle_tooltip()
