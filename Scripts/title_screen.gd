extends Control
#const MAIN_GAME = preload("res://Scenes/main_game.tscn")
const CREDITS = preload("res://Scenes/debug_room.tscn") # <- Placeholder
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("fade_in")

func _on_play_pressed():
	animation_player.play("fade_out_game_start")

func _on_credits_pressed():
	animation_player.play("fade_out_credits")

func _on_exit_pressed():
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_out_game_start":
			get_tree().change_scene_to_packed(CREDITS)
			#get_tree().change_scene_to_packed(MAIN_GAME)
		"fade_out_credits":
			get_tree().change_scene_to_packed(CREDITS)
