extends StaticBody3D

@export var target: Node3D

@onready var barrel = $Barrel
@onready var animation_player = $AnimationPlayer


func _process(_delta):
	barrel.look_at(target.global_transform.origin, Vector3.UP)


func shoot():
	print("shoot")


func _on_shoot_timer_timeout():
	animation_player.play("shoot")
