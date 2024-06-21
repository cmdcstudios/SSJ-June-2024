class_name InventoryDialog
extends PanelContainer

@export var item_slot: PackedScene
@export var item_tooltip: PackedScene

@onready var grid_container: GridContainer = %GridContainer


func open_inv_dialog(inventory:Inventory):
	show()
	clear_inv_dialog()
	
	# if you can avoid it refactor so you don't use else statements
	for slots in inventory.get_slot_number_amount():
		var slot = item_slot.instantiate()
		grid_container.add_child(slot)
		if slots < inventory.get_inventory_contents().size():
			slot.display_item(inventory.get_inventory_contents()[slots])
		slot.slot_sold.connect(_on_slot_sold.bind(inventory))
		if (!SignalManager.item_sold.is_connected(_on_item_sold)):
			SignalManager.item_sold.connect(_on_item_sold.bind(inventory))

func _on_close_button_pressed() -> void:
	hide()

func clear_inv_dialog() -> void:
	for child in grid_container.get_children():
		child.queue_free()

func _on_slot_sold(inventory:Inventory) -> void:
	print("slot removed")
	inventory.remove_slot()
	print(inventory.get_slot_number_amount())
	pass
#
func _on_item_sold(money_amount: int, item_sold: Item, inventory:Inventory):
	pass
	#inventory.remove_item(item_sold)
	#print(inventory._contents)

