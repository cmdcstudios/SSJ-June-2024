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
	item_name_label = get_node("PanelContainer/MarginContainer/VBoxContainer/HeaderContainer/ItemNameLabel") as Label
	var description_label = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/ItemDescription") as Label
	var grid_container = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/GridContainer") as GridContainer
	price = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/Label")
	subviewport = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/SubViewportContainer/SubViewport/")
	scene = item.scene.instantiate()
	print(subviewport)
	subviewport.get_child(0).add_child(scene)
	#visuals.move_child(scene, 0)
	#scene = get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/SubViewportContainer/SubViewport")
	item_name_label.text = item.name
	description_label.text = item.description
	price.text = str(item.sell_price)
	
	#var test = item.scene.instantiate() as Node
	#add_child(scene)

	for attribute in item.item_attributes:
		print(attribute.attribute_type)
		match attribute.attribute_type:
			ItemAttribute.Attribute.PLAIN:
				var attr_slot = ITEM_ATTRIBUTE_SLOT.instantiate()
				attr_slot.get_child(0).get_child(0).texture = attribute.attribute_icon
				attr_slot.get_child(0).get_child(1).text = "Plain"
				grid_container.add_child(attr_slot)
			ItemAttribute.Attribute.FLASHY:
				var attr_slot = ITEM_ATTRIBUTE_SLOT.instantiate()
				attr_slot.get_child(0).get_child(0).texture = attribute.attribute_icon
				attr_slot.get_child(0).get_child(1).text = "Flashy"
				grid_container.add_child(attr_slot)
			ItemAttribute.Attribute.COOL:
				var attr_slot = ITEM_ATTRIBUTE_SLOT.instantiate()
				attr_slot.get_child(0).get_child(0).texture = attribute.attribute_icon
				attr_slot.get_child(0).get_child(1).text = "Cool"
				grid_container.add_child(attr_slot)
			ItemAttribute.Attribute.CUTE:
				var attr_slot = ITEM_ATTRIBUTE_SLOT.instantiate()
				attr_slot.get_child(0).get_child(0).texture = attribute.attribute_icon
				attr_slot.get_child(0).get_child(1).text = "Cute"
				grid_container.add_child(attr_slot)				

func _on_close_button_pressed() -> void:
	tooltip_closed.emit()
	subviewport.queue_free()
	if TooltipInfo.tooltips.size() >= 1:TooltipInfo.tooltips.pop_front()
	queue_free()

func _on_sell_button_pressed() -> void:
	subviewport.queue_free()
	if TooltipInfo.tooltips.size() >= 1:TooltipInfo.tooltips.pop_front()
	SignalManager.item_sold.emit(int(price.text), stored_item)
	queue_free()
