extends StaticBody3D

var damage_taken = 0
var destroyed = false

@onready var animation_player := $AnimationPlayer
@onready var collision_shape := $CollisionShape3D
@onready var particles := $CPUParticles3D
@onready var audio_player := $AudioStreamPlayer3D


func _ready():
	particles.set_emission_box_extents(
		Vector3(collision_shape.shape.extents.x, 1, collision_shape.shape.extents.z)
	)

	StatTracker.add_building()


func destroy():
	if destroyed:
		return

	damage_taken += 10

	if damage_taken < collision_shape.shape.extents.y * 2:
		animation_player.play("damage")
		return

	destroyed = true
	StatTracker.building_destroyed()
	animation_player.play("destroy")
	audio_player.play(0)
