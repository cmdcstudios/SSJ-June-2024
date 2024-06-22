extends Node3D

@onready var UIRoot : CanvasLayer = $UIRoot
@onready var customer_stager = $UIRoot/CustomerStager
@onready var inventory_dialogue : InventoryDialog = %InventoryDialog

@onready var bgm = $BGM
const TRACK_1 = preload("res://Assets/Audio/SSJ2024-Music-SFX/Music/track1.ogg")
const TRACK_2 = preload("res://Assets/Audio/SSJ2024-Music-SFX/Music/track2.ogg")
const TRACK_3 = preload("res://Assets/Audio/SSJ2024-Music-SFX/Music/track3.ogg")
var bgmTracks : Array = [TRACK_1, TRACK_2, TRACK_3]
var bgm_index : int = 1

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
