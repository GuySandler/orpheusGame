extends Node3D

@onready var playerScene := preload("res://player/player.tscn")
var player: CharacterBody3D

@onready var spring_arm := $cameraSpring
@onready var camera := $cameraSpring/maincamera

var mouseSensitivity = 0.00005
var yaw = 0.0
var pitch = 0.0

func _ready() -> void:
	player = playerScene.instantiate()
	add_child(player)
	player.position = Vector3(10, 10, 10)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	update_third_person_camera()

	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()

	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://debug.tscn")

func update_third_person_camera():
	var mouse_delta := Input.get_last_mouse_velocity()
	yaw -= mouse_delta.x * mouseSensitivity
	pitch -= mouse_delta.y * mouseSensitivity
	pitch = clamp(pitch, deg_to_rad(-85), deg_to_rad(10))

	var cam_rot = Basis(Vector3.UP, yaw) * Basis(Vector3.RIGHT, pitch)
	spring_arm.transform.basis = cam_rot

	if player:
		spring_arm.global_position = player.global_position
