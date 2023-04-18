extends StaticBody3D

var target_in_range := false

@onready var barrel := $Node3D/Node3D2
@onready var animation_player := $AnimationPlayer
@onready var projectile_scene := preload("res://projectile/projectile.tscn")
@onready var explosion_scene := preload("res://Explosion Scene.tscn")
@onready var base := $Node3D
@onready var target: PhysicsBody3D = get_node("/root/World1/Ship")
@onready var friendly_fire_detector: RayCast3D = %FriendlyFireDetector
@onready var shoot_timer: Timer = $ShootTimer


func _process(_delta):
	if not target_in_range:
		return

	_look_at_target()


func destroy():
	var explosion = explosion_scene.instantiate()
	get_parent().add_child.call_deferred(explosion)
	explosion.set_global_transform.call_deferred(global_transform)

	queue_free()


func _look_at_target():
	base.look_at(target.global_transform.origin, Vector3.UP)
	base.rotation.x = 0
	base.rotation.z = 0
	barrel.look_at(target.global_transform.origin, Vector3.UP)


func _will_friendly_fire():
	if !friendly_fire_detector.is_colliding():
		return false

	var hit_target := friendly_fire_detector.get_collider()

	return hit_target.is_in_group("destroyable")


func shoot():
	animation_player.play("shoot")

	var projectile = projectile_scene.instantiate()
	get_tree().get_root().add_child(projectile)
	projectile.global_transform = barrel.global_transform


func _on_shoot_timer_timeout():
	if not target_in_range:
		return

	shoot_timer.start()

	if _will_friendly_fire():
		return

	shoot()


func _on_targeting_area_body_entered(body: Node3D):
	if body != target:
		return

	target_in_range = true
	shoot_timer.start()


func _on_targeting_area_body_exited(body: Node3D):
	if body != target:
		return

	target_in_range = false
	shoot_timer.stop()


func _on_ground_detector_body_exited(_body):
	destroy()
