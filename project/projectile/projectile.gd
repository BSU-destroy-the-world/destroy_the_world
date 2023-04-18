extends Node3D

const SPEED := 40.0

@onready var raycast := $RayCast3D
@onready var impact_sphere: Area3D = $ImpactSphere
@onready var explosion_scene := preload("res://Spatial.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("debug_restart"):
		queue_free()


func _physics_process(delta):
	var movement_vector: Vector3 = -global_transform.basis.z * SPEED * delta

	raycast.target_position = Vector3(0, 0, -1 * movement_vector.length())

	if raycast.is_colliding():
		explode(raycast.get_collision_point())
		return

	global_position += movement_vector


func explode(impact_position: Vector3):
	impact_sphere.global_position = impact_position

	for object in impact_sphere.get_overlapping_bodies():
		if object.is_in_group("destroyable"):
			object.destroy()

	var explosion = explosion_scene.instantiate()
	get_parent().add_child(explosion)
	explosion.global_position = impact_position

	queue_free()
