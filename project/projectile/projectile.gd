extends Node3D

const SPEED := 40.0

@onready var raycast := $RayCast3D


func _physics_process(delta):
	var movement_vector: Vector3 = -global_transform.basis.z * SPEED * delta

	raycast.target_position = Vector3(0, 0, -1 * movement_vector.length())

	if raycast.is_colliding():
		movement_vector = raycast.get_collision_point() - global_position

		if raycast.get_collider().is_in_group("destroyable"):
			raycast.get_collider().destroy()

			queue_free()

	global_position += movement_vector
