extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node_or_null("full_food_display_Label"):
		$full_food_display_Label.text = "lettuce: " + str(globalmanager.lettuce) + "
		" +  "tomatos: " + str(globalmanager.tomato) + "
		" +  "cheese: " + str(globalmanager.cheese) + "
		" +  "eggs: " + str(globalmanager.egg) + "
		" +  "bread: " + str(globalmanager.bread) + "
		"

