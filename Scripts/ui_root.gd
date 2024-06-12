extends CanvasLayer

@onready var player: Player = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog

#todo: eventually we will need to pass in different inventories (loaded in from each day)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		inventory_dialog.open_inv_dialog(player.game_inventory)
