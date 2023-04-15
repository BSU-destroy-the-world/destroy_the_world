extends StaticBody3D

@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape3D
@onready var particles := $CPUParticles3D


func _ready():
	particles.set_emission_box_extents(
		Vector3(collision_shape.shape.extents.x, 1, collision_shape.shape.extents.z)
	)


func destroy():
	animation_player.play("destroy")
