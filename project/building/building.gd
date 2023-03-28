extends StaticBody3D

@onready var animation_player := $AnimationPlayer
@onready var turret_mount := %TurretMount
@onready var turret_scene := preload("res://turret/turret.tscn")


func _ready():
	# Random position between -200 and 200
	position = Vector3(randf_range(-200, 200), 0, randf_range(-200, 200))

	scale.y = randf_range(0.5, 1.5)
	scale.x = scale.y * randf_range(0.8, 1.2)
	scale.z = scale.x

	if randf() > 0.8:
		# 20% chance of having a turret
		var turret := turret_scene.instantiate()
		turret_mount.add_child(turret)
		turret.target = get_node("/root/World1/Ship")


func destroy():
	animation_player.play("destroy")
