extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node_or_null("food_display_1"):
		$food_display_1.text = str(globalmanager.food_type_collected_1) + ": " + str(globalmanager[globalmanager.food_type_collected_1])
	
	if get_node_or_null("food_display_2"):
		$food_display_2.text = str(globalmanager.food_type_collected_2) + ": " + str(globalmanager[globalmanager.food_type_collected_2])
	
	if get_node_or_null("food_display_3"):
		$food_display_3.text = str(globalmanager.food_type_collected_3) + ": " + str(globalmanager[globalmanager.food_type_collected_3])





