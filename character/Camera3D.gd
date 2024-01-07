extends Camera3D



# Called when the node enters the scene tree for the first time.
func _ready():
	fov = globalmanager.player_fov


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x += -event.relative.y * (globalmanager.sensitivity / 10)  
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
