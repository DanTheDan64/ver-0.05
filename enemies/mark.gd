extends Marker3D

@export var min_spawn = 5
@export var max_spawn = 12
@onready var spawn = max_spawn

var node = 0
@export var spawn_type = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if spawn_type == 1:
		node = preload("res://enemies/foods/nodes/lettuce.tscn")
	if spawn_type == 2:
		node = preload("res://enemies/foods/nodes/tomato.tscn")
	if spawn_type == 3:
		node = preload("res://enemies/foods/nodes/cheese.tscn")
	if spawn_type == 4:
		node = preload("res://enemies/foods/nodes/egg.tscn")
	if spawn_type == 5:
		node = preload("res://enemies/foods/nodes/bread.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn > 0:
		var instance = node.instantiate()
		instance.position = Vector3(randi_range(-2, 2), 0, randi_range(-2, 2))
		add_child(instance)
		spawn -= 1
