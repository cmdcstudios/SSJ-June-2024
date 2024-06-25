extends Node3D

var time_start = 0
var time_now = 0
var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = Time.get_unix_time_from_system()
	position.y += sin(time) / 250
	print(time)
