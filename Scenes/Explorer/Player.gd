class_name Player
extends CharacterBody3D

signal stepTaken

@export var lookSpeed: float = 7.5
@export var fall_acceleration = 75

@onready var moveTween = null
@export var moveSpeed = 0.15
@export var moveDistance = 5.0

var targetPosition: Vector3

@onready var turnTween = create_tween()
var targetRotation = Quaternion()
var newRotation = Quaternion()

@onready var stateManager: StateManager = get_node("/root/Explorer/State Manager")

func _ready():
	targetPosition = global_transform.origin 

func _physics_process(delta):
	var inputDirection = Vector3.ZERO
	
	if Input.is_action_just_pressed("move_right"):
		inputDirection += Vector3.RIGHT
	if Input.is_action_just_pressed("move_left"):
		inputDirection -= Vector3.RIGHT
	if Input.is_action_just_pressed("move_backward"):
		inputDirection -= Vector3.FORWARD
	if Input.is_action_just_pressed("move_forward"):
		inputDirection += Vector3.FORWARD

	# Only step if there's input & not in combat
	if inputDirection != Vector3.ZERO and stateManager.currentState == 0:
		# Rotate input to local
		inputDirection = global_transform.basis * inputDirection
		inputDirection.y = 0
		inputDirection = inputDirection.normalized() * moveDistance
		
		targetPosition += inputDirection
		move_to_target()

	# Snap-turn
	if Input.is_action_just_pressed("look_left"):
		rotate_smoothly(PI / 2)

	if Input.is_action_just_pressed("look_right"):
		rotate_smoothly(-PI / 2)
	
	# Rotate only if not in combat
	if stateManager.currentState == 0:
		newRotation = newRotation.slerp(targetRotation, lookSpeed * delta)
		global_transform.basis = Basis(targetRotation)
		$Pivot.global_transform.basis = Basis(newRotation)

func move_to_target():
	if moveTween and moveTween.is_valid():
		moveTween.kill()
	moveTween = create_tween()
	moveTween.tween_property(self, "global_position", targetPosition, moveSpeed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	stepTaken.emit()

func rotate_smoothly(angleDelta):
	# Calculate new target by rotating current target by delta yaw
	var yaw_quat = Quaternion(Vector3.UP, angleDelta)
	targetRotation = yaw_quat * targetRotation
