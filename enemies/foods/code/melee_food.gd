extends CharacterBody3D

@export_subgroup("base")
@export var node = preload("res://enemies/enemy drops/lettuce_drop.tscn")
@export var lowest_speed = 1.5
@export var highest_speed = 2.2
@export var lowest_max_distance_to_pack = 5.0
@export var highest_max_distance_to_pack = 12.0
@export var lowest_panic_amount = 2.0
@export var highest_panic_amount = 3.2
@export var hp = 3

@export_subgroup("melee")
var jump_time = 0.0
@export var jump_timer = 30.0
@export var can_jump = true
@export var charge_force = 2.0
@export var aggresion_range = 15
@export var aggresion_level = 1
@export var charge_cooldown = 2.0

@onready var speed = randf_range(lowest_speed, highest_speed)
@onready var max_distance_to_pack = randf_range(lowest_max_distance_to_pack, highest_max_distance_to_pack)
@onready var panic_amount = randf_range(lowest_panic_amount, highest_panic_amount)

var distance_to_pack = 0
var wait_time = randf_range(1, 4)
var panic = false



#Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 12

func _ready():
	scale.y = randf_range(0.8, 1.2)
	$Timer.start(wait_time)
	rotation_degrees.y += randi_range(-360, 360)


func _process(delta):
	pass

func _physics_process(delta):
	if panic == false:
		#if too far from mark, point towards mark to go towards it
		distance_to_pack = global_position.distance_to(Vector3($"..".global_position.x, global_position.y, $"..".global_position.z))
		if distance_to_pack > max_distance_to_pack:
			look_at(Vector3($"..".global_position.x, global_position.y , $"..".global_position.z))
		
		#move forward
		velocity = -global_transform.basis.z * speed
	
	if aggresion_level == 2 and global_position.distance_to(get_parent().get_node("%player").position) < aggresion_range:
		if global_position.distance_to($"..".global_position) < max_distance_to_pack + 2:
			panic = true
			
			if $agro_timer.is_stopped():
				$agro_timer.start(0.1)
				
				look_at(get_parent().get_node("%player").position)
				rotation.x = 0
				
				speed *= panic_amount
				max_distance_to_pack *= panic_amount
	
	#death
	if hp <= 0:
		var instance = node.instantiate()
		instance.position = position
		get_parent().add_child(instance)
		queue_free()
	
	#gravity
	velocity.y = -gravity + jump_time
	
	if jump_time > 0:
		jump_time -= 15 * delta
	jump_time = clamp(jump_time, 0, jump_timer)
	move_and_slide()


func _on_timer_timeout():
	#point to random dir + redundances to stop twitching
	if panic == false:
		if distance_to_pack < max_distance_to_pack - 1:
			rotation_degrees.y += randi_range(-360, 360)
	
	$Timer.stop()
	wait_time = randf_range(2, 4)
	$Timer.start(wait_time)


#damage
func _on_area_3d_area_entered(area):
	if area.is_in_group("bullets"):
		hp -= 1
		panic = true
		
		if $agro_timer.is_stopped():
			$agro_timer.start(0.1)
			
			look_at(get_parent().get_node("%player").position)
			rotation.x = 0
			
			speed *= panic_amount
			max_distance_to_pack *= panic_amount


func _on_agro_timer_timeout():
	if global_position.distance_to(get_parent().get_node("%player").position) > aggresion_range and global_position.distance_to($"..".global_position) > max_distance_to_pack + 2:
		panic = false
		speed /= panic_amount
		max_distance_to_pack /= panic_amount
		$agro_timer.stop()
	else:
		look_at(get_parent().get_node("%player").position)
		rotation.x = 0
		velocity = -global_transform.basis.z * speed * charge_force
		
		if can_jump == true and is_on_floor():
			jump_time = jump_timer
		$agro_timer.start(charge_cooldown)









