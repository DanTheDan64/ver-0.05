extends Area3D
var speed = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$".".look_at(get_parent().get_node("%player").position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += -global_transform.basis.z * speed * delta 



func _on_area_entered(area):
	pass


func _on_body_entered(body):
	if body is StaticBody3D or body is CharacterBody3D:
		queue_free()
