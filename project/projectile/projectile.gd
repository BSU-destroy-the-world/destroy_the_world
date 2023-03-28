extends Node3D

const SPEED := 15.0

@onready var raycast := $RayCast3D


func _physics_process(delta):
	var movement_vector := Vector3(0, 0, -SPEED * delta)

	raycast.target_position = movement_vector

	if raycast.is_colliding():
		movement_vector = raycast.get_collision_point() - global_position

		if raycast.get_collider().is_in_group("destroyable"):
			raycast.get_collider().destroy()

			queue_free()

	global_position += movement_vector
