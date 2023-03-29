extends StaticBody3D

@export var target: Node3D

@onready var barrel = $Barrel
@onready var animation_player = $AnimationPlayer
@onready var projectile_scene = preload("res://projectile/projectile.tscn")


func _process(_delta):
	barrel.look_at(target.global_transform.origin, Vector3.UP)


func shoot():
	var projectile = projectile_scene.instantiate()
	get_tree().get_root().add_child(projectile)
	projectile.global_transform = barrel.global_transform


func _on_shoot_timer_timeout():
	animation_player.play("shoot")
