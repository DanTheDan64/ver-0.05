extends PathFollow3D

var speed = 0.005



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += speed * delta
