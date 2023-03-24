extends Node3D

@export var speed := 10.0

@onready var camera := $Camera3D
@onready var camera_target := $Target
@onready var focus := $Focus


func _process(delta):
	var look_input := Input.get_vector("look_left", "look_right", "look_up", "look_down")

	rotate_y(-look_input.x * delta * 5)
	focus.global_position.y += -look_input.y * delta * 5

	var distance: float = camera.global_position.distance_to(camera_target.global_position)

	camera.global_position = camera.global_position.move_toward(
		camera_target.global_position, delta * speed * distance
	)

	camera_target.look_at(focus.global_position)

	camera.global_rotation = camera_target.global_rotation
