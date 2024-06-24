extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pause()


func resume():
	$AnimationPlayer.play_backwards("blur")


func pause():
	$AnimationPlayer.play("blur")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	$AnimationPlayer.play_backwards("blur")
	await get_tree().create_timer(1.5).timeout
	self.queue_free()
