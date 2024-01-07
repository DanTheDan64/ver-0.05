extends Area3D
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += -global_transform.basis.z * speed * delta 



func _on_area_entered(area):
	queue_free()


func _on_body_entered(body):
	if body is StaticBody3D:
		queue_free()
