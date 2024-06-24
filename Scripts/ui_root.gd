extends CanvasLayer

@onready var player: Player = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var start_button : Button = $StartDayButton
@onready var game_over_label : Label = $GameOverLabel

#todo: eventually we will need to pass in different inventories (loaded in from each day)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		inventory_dialog.open_inv_dialog(player.game_inventory)


func _ready():
	remove_child(game_over_label)
	SignalManager.end_day.connect(_on_end_day)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_debug_on_pressed():
	$CustomerStager.debugger_activate()

func _on_debug_off_pressed():
	$CustomerStager.debugger_deactivate()


func _on_start_day_button_pressed():
	SignalManager.start_day.emit()
	start_button.hide()
	#remove_child(start_button)

func  _on_end_day():
	add_child(start_button)
	

func show_game_over() -> void:
	add_child(game_over_label)
