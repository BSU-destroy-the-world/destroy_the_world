extends Node3D

@export var speed := 4.2
@export var camera: Camera3D
@export var target: Node3D
@export var focus: Node3D


func _process(delta):
	var look_input := Input.get_vector("look_left", "look_right", "look_up", "look_down")

	rotate_y(look_input.x * delta * 2)
	focus.global_position.y += -look_input.y * delta * 2

	var distance := camera.global_position.distance_to(target.global_position)

	camera.global_position = camera.global_position.move_toward(
		target.global_position, delta * speed * distance
	)

	camera.look_at(focus.global_position)
