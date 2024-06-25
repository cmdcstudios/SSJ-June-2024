extends Node3D

@onready var UIRoot : CanvasLayer = $UIRoot
@onready var customer_stager = $UIRoot/CustomerStager
@onready var inventory_dialogue : InventoryDialog = %InventoryDialog
@onready var pause_menu = $"Pause Menu/Darken Layer"
@onready var shop_sellable = $SubViewportContainer/SubViewport/shop_sellable
@onready var animation_player = $"Pause Menu/AnimationPlayer"

@onready var bgm = $BGM
const TRACK_1 = preload("res://Assets/Audio/SSJ2024-Music-SFX/Music/track1.ogg")
const TRACK_2 = preload("res://Assets/Audio/SSJ2024-Music-SFX/Music/track2.ogg")
const TRACK_3 = preload("res://Assets/Audio/SSJ2024-Music-SFX/Music/track3.ogg")
var bgmTracks : Array = [TRACK_1, TRACK_2, TRACK_3]
var bgm_index : int = 1

const BSOD_ENDING = preload("res://Scenes/bsod_ending.tscn")
var day_index : int = -1
var current_day : DayResource

func _on_start_day():
	animation_player.play("fade_in")
	day_index += 1
	current_day = GameManager.get_dayresource(day_index)
	GameManager.current_game_state = GameManager.GameFlags.NORMAL
	if current_day == null:
		print("That was the final day!")
		UIRoot.show_game_over()
	else:
		print("Today is day: " + str(current_day.ID))
		if current_day.inventory.everything_must_go:
			GameManager.current_game_state = GameManager.GameFlags.SELLABLE
			GameManager.emg = true
		inventory_dialogue.open_inv_dialog(current_day.inventory)
		customer_stager.begin_new_queue(current_day.customer_queue)

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.start_day.connect(_on_start_day)
	SignalManager.item_sold.connect(_on_item_sold)
	#SignalManager.start_day.emit()
	#remove_child(UIRoot.get_node("StartDayButton"))
	ready_3d_items()

func _on_bgm_next_pressed():
	if bgm_index < 2:
		bgm_index += 1
	elif bgm_index >= 2:
		bgm_index = 0
	bgm.stream = bgmTracks[bgm_index]
	bgm.play()

func _on_bgm_prev_pressed():
	if bgm_index > 0:
		bgm_index -= 1
	elif bgm_index <= 0:
		bgm_index = bgmTracks.size() - 1
	bgm.stream = bgmTracks[bgm_index]
	bgm.play()

func _on_music_toggle_pressed():
	if bgm.playing == true:
		bgm.stop()
	elif bgm.playing == false:
		bgm.play()


func _on_bgm_finished():
	if bgm_index < 2:
		bgm_index += 1
	elif bgm_index >= 2:
		bgm_index = 0
	bgm.stream = bgmTracks[bgm_index]
	bgm.play()


func _on_pause_button_pressed():
	pause_menu.visible = !pause_menu.visible


func _on_close_menu_button_pressed():
	pause_menu.visible = false

# Create collision areas for each 3D object in the scene. A good compromise
# to not have create each one by hand.
func ready_3d_items():
	for item_3d in shop_sellable.get_children():
		if (item_3d is MeshInstance3D and item_3d.has_node("SellableItem")):
			item_3d.create_convex_collision(false, true)
			var area_3d = item_3d.get_node("SellableItem/Area3D")
			for child in item_3d.get_children():
				if (child is StaticBody3D):
					child.reparent(area_3d)

func _on_credits_button_pressed():
	# caused game to crash with null reference to subviewport layer
	# instantiate and add_child method used as workaround
	# also avoids scene changer flicker bug
	#animation_player.play("fade_out_credits")
	var credits : Node = load("res://Scenes/credits.tscn").instantiate()
	pause_menu.add_child(credits)

func _on_main_menu_button_pressed():
	animation_player.play("fade_out_title")

func _on_item_sold(money_amount: int, item_sold: Item):
	if item_sold.id == 70:
		GameManager.current_game_state == GameManager.GameFlags.ENDGAME
		get_tree().change_scene_to_packed(BSOD_ENDING)
