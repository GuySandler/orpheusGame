extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 5.0
@export var gravity := 9.8
@onready var camera := get_viewport().get_camera_3d()

func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.y -= 1
	if Input.is_action_pressed("ui_up"):
		input_dir.y += 1

	input_dir = input_dir.normalized()

	# Default to no movement
	var move_dir = Vector3.ZERO

	if input_dir != Vector2.ZERO and camera:
		var cam_forward = -camera.global_transform.basis.z
		var cam_right = camera.global_transform.basis.x

		cam_forward.y = 0
		cam_right.y = 0
		cam_forward = cam_forward.normalized()
		cam_right = cam_right.normalized()

		move_dir = (cam_forward * input_dir.y + cam_right * input_dir.x).normalized()

	# Apply movement to horizontal axes
	var horizontal_velocity = move_dir * speed
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z

	# Gravity & jumping
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity
		else:
			velocity.y = 0

	move_and_slide()
