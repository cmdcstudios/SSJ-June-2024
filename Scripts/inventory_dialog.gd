class_name InventoryDialog
extends PanelContainer

@export var item_slot: PackedScene
@onready var grid_container: GridContainer = %GridContainer

func open_inv_dialog(inventory:Inventory):
	show()
	clear_inv_dialog()
	for item in inventory.get_inventory_contents():
		var slot = item_slot.instantiate()
		grid_container.add_child(slot)
		slot.display_item(item)

func _on_close_button_pressed() -> void:
	hide()

func clear_inv_dialog() -> void:
	for child in grid_container.get_children():
		child.queue_free()
