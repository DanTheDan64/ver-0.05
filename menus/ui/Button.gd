extends Button
var scl = 1
var scl_to = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scl = move_toward(scl, scl_to, 1 * delta)
	scl = clamp(scl, 1, 1.1)
	
	scale.x = scl
	scale.y = scl


func _on_mouse_entered():
	scl_to = 1.1

func _on_mouse_exited():
	scl_to = 1

