extends CanvasLayer

@onready var player: Player = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		inventory_dialog.open_inv_dialog(player.game_inventory)
