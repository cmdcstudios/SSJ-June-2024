class_name Tooltip
extends PanelContainer

static var tooltips: Array[Tooltip] = []

signal item_sold
signal tooltip_closed

# Tooltip Elements
var item_name_label: Label = null
var price: Label = null

func load_item_info(item:Item):
	item_name_label = get_node("MarginContainer/VBoxContainer/HeaderContainer/ItemNameLabel") as Label
	var description_label = get_node("MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/ItemDescription") as Label
	var grid_container = get_node("MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/GridContainer") as GridContainer
	price = get_node("MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/Label")
	item_name_label.text = item.name
	description_label.text = item.description
	price.text = str(item.sell_price)
	
	if (item.item_attributes.size() == 1):
		if item.item_attributes[0].attribute_type == ItemAttribute.Attribute.PLAIN:
			grid_container.get_child(0).get_child(0).get_child(1).text = "Plain"
			print(grid_container.get_child(0).get_child(0).get_child(1))

func _on_close_button_pressed() -> void:
	tooltip_closed.emit()
	if TooltipInfo.tooltips.size() >= 1:TooltipInfo.tooltips.pop_front()
	queue_free()

func _on_item_sold() -> void:
	if TooltipInfo.tooltips.size() >= 1:TooltipInfo.tooltips.pop_front()
	print(int(price.text))
	pass # Replace with function body.

func _on_button_pressed() -> void:
	item_sold.emit()
	queue_free()
