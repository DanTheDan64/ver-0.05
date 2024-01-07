extends Node2D

@onready var menu_section = $general

# MAKE IOT SO THE THE SOUND OPTIONS ARE !S INSTEAD OF 100S
func _ready():
	$Path2D/PathFollow2D.progress_ratio = globalmanager.title_path_progress
	
	$general/sensitivity_panel/sensitivity_slider.value = globalmanager.sensitivity # set sensitivity to sensitivity slider
	$general/fov_panel/fov_slider.value = globalmanager.player_fov
	

	$audio/music/music_slider.value = globalmanager.music * 100
	$audio/sound_effects/sound_effects_slider.value = globalmanager.sound_effects * 100
	$audio/ambient/ambient_slider.value = globalmanager.ambient * 100
	$audio/master_volume/music_slider.value = globalmanager.master_volume * 100
	


func _process(delta):
	
	
	
	globalmanager.title_path_progress = $Path2D/PathFollow2D.progress_ratio
	
	#control sensitvity
	globalmanager.sensitivity = $general/sensitivity_panel/sensitivity_slider.value # make it so that slider changes sensitivity
	$general/sensitivity_panel/sensitivity_label.text = "sensitivity: " + str(globalmanager.sensitivity) # show sensitivity in settings
	
	#control fov
	$general/fov_panel/fov_slider.value = snapped($general/fov_panel/fov_slider.value, 5)
	globalmanager.player_fov = $general/fov_panel/fov_slider.value
	$general/fov_panel/fov_label.text = "fov: " + str(globalmanager.player_fov)
	
	
	#control music
	$audio/music/music_slider.value = snapped($audio/music/music_slider.value, 5)
	globalmanager.music = $audio/music/music_slider.value / 100
	$audio/music/music_label.text = "music: " + str(globalmanager.music * 100)
	
	#control sound effects
	$audio/sound_effects/sound_effects_slider.value = snapped($audio/sound_effects/sound_effects_slider.value, 5)
	globalmanager.sound_effects = $audio/sound_effects/sound_effects_slider.value / 100
	$audio/sound_effects/sound_effects_label.text = "sound_effects: " + str(globalmanager.sound_effects * 100)
	
	#control ambient
	$audio/ambient/ambient_slider.value = snapped($audio/ambient/ambient_slider.value, 5)
	globalmanager.ambient = $audio/ambient/ambient_slider.value / 100
	$audio/ambient/ambient_label.text = "ambient: " + str(globalmanager.ambient * 100)
	
	#control master volume
	$audio/master_volume/music_slider.value = snapped($audio/master_volume/music_slider.value, 5)
	globalmanager.master_volume = $audio/master_volume/music_slider.value / 100
	$audio/master_volume/music_label.text = "master_volume: " + str(globalmanager.master_volume * 100)
	



func _on_back_pressed():
	get_tree().change_scene_to_file("res://menus/scenes/menu_main.tscn")

func _on_reset_audio_pressed():
	globalmanager.music = 1
	globalmanager.ambient = 1
	globalmanager.sound_effects = 1
	globalmanager.master_volume = 1
	
	$audio/music/music_slider.value = globalmanager.music * 100
	$audio/sound_effects/sound_effects_slider.value = globalmanager.sound_effects * 100
	$audio/ambient/ambient_slider.value = globalmanager.ambient * 100
	$audio/master_volume/music_slider.value = globalmanager.master_volume * 100



func _on_section_general_pressed():
	if not menu_section == $general:
		menu_section.hide()
		$general.show()
		menu_section = $general

func _on_section_controls_pressed():
	if not menu_section == $controls:
		menu_section.hide()
		$controls.show()
		menu_section = $controls

func _on_section_accesibility_pressed():
	if not menu_section == $accesibility:
		menu_section.hide()
		$accesibility.show()
		menu_section = $accesibility

func _on_section_video_pressed():
	if not menu_section == $video:
		menu_section.hide()
		$video.show()
		menu_section = $video

func _on_section_audio_pressed():
	if not menu_section == $audio:
		menu_section.hide()
		$audio.show()
		menu_section = $audio


func _on_tree_entered():
	globalmanager.music /= globalmanager.master_volume
	globalmanager.ambient /= globalmanager.master_volume
	globalmanager.sound_effects /= globalmanager.master_volume
	
	print("music: " + str(globalmanager.music))
	print("sound_effects: " + str(globalmanager.sound_effects))
	print("ambient: " + str(globalmanager.ambient))
	print("master_volume: " + str(globalmanager.master_volume))
	print("
	")

func _on_tree_exiting():
	globalmanager.music *= globalmanager.master_volume
	globalmanager.ambient *= globalmanager.master_volume
	globalmanager.sound_effects *= globalmanager.master_volume
	
	print("music: " + str(globalmanager.music))
	print("sound_effects: " + str(globalmanager.sound_effects))
	print("ambient: " + str(globalmanager.ambient))
	print("master_volume: " + str(globalmanager.master_volume))
	print("
	")
