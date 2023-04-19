extends Node3D

const SPEED := 40.0

var _is_players := false

@onready var raycast := $RayCast3D
@onready var impact_sphere: Area3D = $ImpactSphere
@onready var explosion_scene := preload("res://Spatial.tscn")
@onready var audio_player := $AudioStreamPlayer3D

func _ready():
	audio_player.play(0)

func _process(_delta):
	if Input.is_action_just_pressed("debug_restart"):
		queue_free()


func _physics_process(delta):
	var movement_vector: Vector3 = -global_transform.basis.z * SPEED * delta

	raycast.target_position = Vector3(0, 0, -1 * movement_vector.length())

	if (
		raycast.is_colliding()
		and (not _is_players or not raycast.get_collider().is_in_group("ship"))
	):
		explode(raycast.get_collision_point())
		return

	global_position += movement_vector


func set_is_players():
	_is_players = true


func explode(impact_position: Vector3):
	impact_sphere.global_position = impact_position

	for object in impact_sphere.get_overlapping_bodies():
		if object.is_in_group("destroyable"):
			object.destroy()

	var explosion = explosion_scene.instantiate()
	get_parent().add_child(explosion)
	explosion.global_position = impact_position

	queue_free()
