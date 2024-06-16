class_name Tooltip
extends CanvasLayer

static var tooltips: Array[Tooltip] = []

signal tooltip_closed
signal tooltip_changed

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
	
	if (item.item_attributes.size() == 1):
		if item.item_attributes[0].attribute_type == ItemAttribute.Attribute.PLAIN:
			grid_container.get_child(0).get_child(0).get_child(1).text = "Plain"
			#print(grid_container.get_child(0).get_child(0).get_child(1))

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
