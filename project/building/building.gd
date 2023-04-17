extends StaticBody3D

var destroyed = false

@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape3D
@onready var particles := $CPUParticles3D


func _ready():
	particles.set_emission_box_extents(
		Vector3(collision_shape.shape.extents.x, 1, collision_shape.shape.extents.z)
	)

	StatTracker.add_building()


func destroy():
	if destroyed:
		return

	destroyed = true
	StatTracker.building_destroyed()
	animation_player.play("destroy")
