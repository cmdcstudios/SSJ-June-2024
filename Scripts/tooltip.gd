class_name Tooltip
extends CanvasLayer

signal tooltip_closed
signal tooltip_changed

const ITEM_ATTRIBUTE_SLOT = preload("res://Scenes/item_attribute_slot.tscn")

# Tooltip Elements
var stored_item: Item = null
var item_name_label: Label = null
var price: Label = null
var scene = null
var subviewport = null

func load_item_info(item:Item):
	stored_item = item
	'''
	item_name_label = get_node("PanelContainer/MarginContainer/VBoxContainer/HeaderContainer/ItemNameLabel") as Label
	var description_label = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/ItemDescription") as Label
	var grid_container = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/GridContainer") as GridContainer
	price = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/Label")
	subviewport = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/SubViewportContainer/SubViewport/")
	scene = item.scene.instantiate()
	subviewport.get_child(0).add_child(scene)
	#visuals.move_child(scene, 0)
	#scene = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/SubViewportContainer/SubViewport")
	item_name_label.text = item.name
	description_label.text = item.description
	price.text = str(item.sell_price)
	'''
	item_name_label = %ItemNameLabel
	var description_label : Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/ItemDescription
	var attr_box : GridContainer = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/GridContainer
	var price : Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/PriceLabel
	var item_sprite : TextureRect = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/SpritePanel
	
	item_sprite.texture = item.inventory_icon
	price.text = str(item.sell_price)
	
	for attribute in item.item_attributes:
		var attr_slot = ITEM_ATTRIBUTE_SLOT.instantiate()
		attr_slot.get_child(0).get_child(0).texture = attribute.attribute_icon
		attr_box.add_child(attr_slot)
		match attribute.attribute_type:
			ItemAttribute.Attribute.PLAIN:
				attr_slot.get_child(0).get_child(1).text = "Plain"
			ItemAttribute.Attribute.FLASHY:
				attr_slot.get_child(0).get_child(1).text = "Flashy"
			ItemAttribute.Attribute.COOL:
				attr_slot.get_child(0).get_child(1).text = "Cool"
			ItemAttribute.Attribute.CUTE:
				attr_slot.get_child(0).get_child(1).text = "Cute"
			ItemAttribute.Attribute.SOLID:
				attr_slot.get_child(0).get_child(1).text = "Cute"

func _on_close_button_pressed() -> void:
	tooltip_closed.emit()
	#subviewport.queue_free()
	if TooltipInfo.tooltips.size() >= 1:
		for tip in TooltipInfo.tooltips:
			TooltipInfo.tooltips.pop_front()
	queue_free()

func _on_sell_button_pressed() -> void:
	#subviewport.queue_free()
	if TooltipInfo.tooltips.size() >= 1:
		#TooltipInfo.tooltips = []
		for tip in TooltipInfo.tooltips:
			tip.queue_free()
			TooltipInfo.tooltips.pop_front()
		print(TooltipInfo.tooltips)
	SignalManager.item_sold.emit(int(stored_item.sell_price), stored_item)
	#SignalManager.item_pref.emit(stored_item.item_attributes[0])
	queue_free()
