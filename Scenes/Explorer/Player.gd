extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14

# How fast the player can look around left and right
@export var lookSpeed = 1

# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
var target_rotation = Vector3.ZERO

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	var lookDirection = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	# Ground Velocity
	# Needs to be converted from local space to global space, hmmmm...
	# Maybe something like position.FORWARD might work
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	# Turn the character around so they can look around
	if Input.is_action_pressed("look_left"):
		lookDirection.y += 0.1 * lookSpeed

	if Input.is_action_pressed("look_right"):
		lookDirection.y -= 0.1 * lookSpeed
		
	# Turn the character
	rotation += lookDirection

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
