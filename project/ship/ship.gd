extends CharacterBody3D

const SPEED = 5.0

@onready var camera_mount := $CameraMount


func _physics_process(_delta):
	var direction = _get_camera_oriented_input()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var vertical_input = (
		Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	)

	if vertical_input:
		velocity.y = move_toward(velocity.y, vertical_input * SPEED, SPEED)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _get_camera_oriented_input() -> Vector3:
	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	var input := Vector3.ZERO
	# This is to ensure that diagonal input isn't stronger than axis aligned input
	input.x = raw_input.x * sqrt(1.0 - raw_input.y * raw_input.y / 2.0)
	input.z = raw_input.y * sqrt(1.0 - raw_input.x * raw_input.x / 2.0)

	input = camera_mount.global_transform.basis * input
	input.y = 0.0
	return input
