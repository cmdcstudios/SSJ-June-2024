extends CanvasLayer


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_out_game_start":
			get_tree().change_scene_to_packed(SceneManager.MAIN_GAME)
		"fade_out_credits":
			get_tree().change_scene_to_packed(SceneManager.CREDITS)
		"fade_out_title":
			get_tree().change_scene_to_packed(SceneManager.TITLE)
