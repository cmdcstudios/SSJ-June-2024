extends Node3D

@onready var UIRoot : CanvasLayer = $UIRoot
@onready var customer_stager : CustomerStager = $UIRoot/CustomerStager
@onready var inventory_dialogue : InventoryDialog = %InventoryDialog
@onready var shop_sellable = $SubViewportContainer/SubViewport/shop_sellable

var day_index : int = -1
var current_day : DayResource

func _on_start_day():
	day_index += 1
	current_day = GameManager.get_dayresource(day_index)
	if current_day == null:
		print("That was the final day!")
		UIRoot.show_game_over()
	else:
		print("Today is day: " + str(current_day.ID))
		inventory_dialogue.open_inv_dialog(current_day.inventory)
		customer_stager.begin_new_queue(current_day.customer_queue)


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.start_day.connect(_on_start_day)
	ready_3d_items()

func ready_3d_items():
	for item_3d in shop_sellable.get_children():
		if (item_3d is MeshInstance3D and item_3d.has_node("SellableItem")):
			item_3d.create_convex_collision(false, true)
			var area_3d = item_3d.get_node("SellableItem/Area3D")
			for child in item_3d.get_children():
				if (child is StaticBody3D):
					child.reparent(area_3d)
