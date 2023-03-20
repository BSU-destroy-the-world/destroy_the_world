extends CharacterBody3D

const SPEED = 5.0


func _physics_process(_delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

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
