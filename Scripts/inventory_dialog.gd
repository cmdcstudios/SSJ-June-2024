class_name InventoryDialog
extends PanelContainer

@export var item_slot: PackedScene
@onready var grid_container: GridContainer = %GridContainer

func open_inv_dialog(inventory:Inventory):
	show()
	clear_inv_dialog()
	
	# if you can avoid it refactor so you don't use else statements
	for slots in inventory.get_slot_number():
		var slot = item_slot.instantiate()
		grid_container.add_child(slot)
		if slots < inventory.get_inventory_contents().size():
			slot.display_item(inventory.get_inventory_contents()[slots])

func _on_close_button_pressed() -> void:
	hide()

func clear_inv_dialog() -> void:
	for child in grid_container.get_children():
		child.queue_free()
