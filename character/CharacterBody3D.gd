extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 4.5
@onready var sens = globalmanager.sensitivity / 10

var max_jumps = 2
var jumps = max_jumps
var jump_length = 0.3
var jump_time = 0
var jumping = false

var dash_force = 10
var dash_cooldown = 4
var dash_timer = 0
var paused = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 15

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y += -event.relative.x * sens

func _physics_process(delta):
	
	if Input.is_action_just_pressed("menu"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().change_scene_to_file("res://menus/scenes/menu_main.tscn")
	
	if Input.is_action_just_pressed("shoot"):
		var node = preload("res://guns/nodes/bullet.tscn")
		var instance = node.instantiate()
		instance.position = $Camera3D/gun.global_position
		instance.rotation = $Camera3D/gun.global_rotation
		
		get_parent().add_child(instance)
	
	
	if is_on_floor():
		jumps = max_jumps
	else:
		if jumps == max_jumps:
			jumps = max_jumps - 1
		velocity.y -= gravity * delta
	
	#dash cooldown
	if dash_timer > 0:
		dash_timer -= 10 * delta
	dash_timer = clamp(dash_timer, 0, dash_cooldown)
	
	# handle dash
	if Input.is_action_just_pressed("ability") and dash_timer == 0:
		dash_timer = dash_cooldown
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and jumping == false and jumps > 0:
		jumping = true
		jump_time = jump_length
		jumps -= 1
	
	if Input.is_action_just_released("jump"):
		jumping = false
		jump_time = jump_length
	
	if jump_time > 0 and jumping == true:
		velocity.y = JUMP_VELOCITY
		jump_time -= 1 * delta
	
	if jump_time <= 0:
		jumping = false
		jump_time = jump_length
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	# Get the input direction and handle the movement/deceleration
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity += -global_transform.basis.z * dash_timer * dash_force
	move_and_slide()


