extends CanvasLayer

@onready var player: Player = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog

#todo: eventually we will need to pass in different inventories (loaded in from each day)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		inventory_dialog.open_inv_dialog(player.game_inventory)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_debug_on_pressed():
	$CustomerStage.debugger_activate()

func _on_debug_off_pressed():
	$CustomerStage.debugger_deactivate()


func _on_start_day_button_pressed():
	SignalManager.start_day.emit()
	remove_child($StartDayButton)
