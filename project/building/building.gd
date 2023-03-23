extends StaticBody3D

@onready var animation_player := $AnimationPlayer


func _ready():
	# Random position between -200 and 200
	position = Vector3(randf_range(-200, 200), 0, randf_range(-200, 200))

	scale.y = randf_range(0.5, 1.5)
	scale.x = scale.y * randf_range(0.8, 1.2)
	scale.z = scale.x


func destroy():
	animation_player.play("destroy")
