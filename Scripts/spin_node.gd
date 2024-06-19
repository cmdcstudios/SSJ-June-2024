extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += Vector3(0, 1.0, 0) * delta
