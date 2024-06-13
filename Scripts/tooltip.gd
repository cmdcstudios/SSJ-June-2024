class_name Tooltip
extends PopupPanel

#@onready var item_name: Label = $MarginContainer/VBoxContainer/HeaderContainer/ItemName

func load_item_info(item:Item):
	var item_name_label = get_node("MarginContainer/VBoxContainer/HeaderContainer/ItemNameLabel") as Label
	var description_label = get_node("MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/ItemDescription") as Label
	var grid_container = get_node("MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Descriptions/GridContainer") as GridContainer
	var price = get_node("MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Visuals/Label")
	item_name_label.text = item.name
	description_label.text = item.description
	price.text = str(item.sell_price) + "G"
	
	if (item.item_attributes.size() == 1):
		if item.item_attributes[0].attribute_type == ItemAttribute.Attribute.PLAIN:
			grid_container.get_child(0).get_child(0).get_child(1).text = "Plain"
			print(grid_container.get_child(0).get_child(0).get_child(1))
	#item_name.text = item.name


func _on_close_button_pressed() -> void:
	self.get_parent().toggle_tooltip() # This needs to be brought out into a global variable and func
	queue_free()
