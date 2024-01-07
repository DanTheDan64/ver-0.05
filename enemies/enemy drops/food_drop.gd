extends RigidBody3D
@export var food_type = "lettuce"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		globalmanager[food_type] += 1
		if globalmanager.food_type_collected_1 != food_type and globalmanager.food_type_collected_2 != food_type and globalmanager.food_type_collected_3 != food_type:
			globalmanager.food_type_collected_3 = globalmanager.food_type_collected_2
			globalmanager.food_type_collected_2 = globalmanager.food_type_collected_1
			globalmanager.food_type_collected_1 = food_type
		
		queue_free()
