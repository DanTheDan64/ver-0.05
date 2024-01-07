extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$ui.show()
	$full_food_display.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("1"):
		$ui.hide()
		$full_food_display.show()
	else:
		$ui.show()
		$full_food_display.hide()
