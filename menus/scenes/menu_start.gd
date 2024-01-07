extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Path2D/PathFollow2D.progress_ratio = globalmanager.title_path_progress


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	globalmanager.title_path_progress = $Path2D/PathFollow2D.progress_ratio


func _on_start_pressed():
	get_tree().change_scene_to_file("res://menus/scenes/menu_main.tscn")
