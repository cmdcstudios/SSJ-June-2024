class_name Tooltip
extends CanvasLayer

signal tooltip_changed

const ITEM_ATTRIBUTE_SLOT = preload("res://Scenes/item_attribute_slot.tscn")
const BSOD_ENDING = preload("res://Scenes/bsod_ending.tscn")

# Tooltip Elements
var stored_item: Item = null
var item_name_label: Label = null
var price: Label = null
var scene = null
var subviewport: SubViewport  = null

func load_item_info(item:Item):
	stored_item = item
	#subviewport = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/SubViewportContainer/SubViewport/")
	subviewport = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/ItemPreview/SubViewportContainer/SubViewport/")
	item_name_label = %ItemNameLabel
	#subviewport = %SubViewport
	var description_label : Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/ItemDescription
	var attr_box : GridContainer = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/GridContainer
	var price : Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/Price/PriceLabel

	#item_sprite.texture = item.inventory_icon
	price.text = str(item.sell_price)
	item_name_label.text = item.name
	description_label.text = item.description
	scene = item.scene.instantiate()
	subviewport.get_child(0).add_child(scene)
	
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
				attr_slot.get_child(0).get_child(1).text = "Solid"
			ItemAttribute.Attribute.CURIOUS:
				attr_slot.get_child(0).get_child(1).text = "Curious"
			ItemAttribute.Attribute.STRANGE:
				attr_slot.get_child(0).get_child(1).text = "Strange"
			ItemAttribute.Attribute.MAGICAL:
				attr_slot.get_child(0).get_child(1).text = "Magical"
			ItemAttribute.Attribute.NASTY:
				attr_slot.get_child(0).get_child(1).text = "Nasty"

func _on_close_button_pressed() -> void:
	#SignalManager.tooltip_closed.emit()
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
	queue_free()
