extends CharacterBody3D

const SPEED = 25.0
const DODGE_SPEED = 150.0
const DODGE_SLOWDOWN = 10.0

var can_dodge := true
var dodging := false
var target: Node3D = null
var target_collision_point := Vector3.ZERO

@export var bullet : PackedScene

@onready var camera_mount := $CameraMount
@onready var dodge_cooldown_timer := $DodgeCooldownTimer
@onready var reticle := $GUI/Reticle/Marker2D
@onready var gun :=  $Marker3D
@onready var bullet2 := preload("res://projectile/projectile.tscn")


func _process(_delta):
	# Raycast from reticle to find target and set it
	var ray = camera_mount.camera.project_ray_normal(reticle.global_position)
	var ray_from = camera_mount.camera.project_ray_origin(reticle.global_position)
	var ray_to = ray_from + ray * 1000

	var space_state = get_world_3d().direct_space_state
	var parameters = PhysicsRayQueryParameters3D.create(ray_from, ray_to)
	var result = space_state.intersect_ray(parameters)

	if result:
		if target != result.collider:
			_set_target(result.collider, result.position)

	else:
		target = null
		
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instantiate()
		get_tree().get_root().add_child(b)
		b.global_position = gun.global_position
		b.look_at(target_collision_point)


func _physics_process(_delta):
	var direction = _get_camera_oriented_input()
	var just_dodged = Input.is_action_just_pressed("dodge")

	if can_dodge && direction && just_dodged && !dodging:
		var normalized_direction = direction.normalized()

		velocity.x = normalized_direction.x * DODGE_SPEED
		velocity.z = normalized_direction.z * DODGE_SPEED

		dodging = true
		can_dodge = false

		dodge_cooldown_timer.start()

	if dodging:
		velocity = velocity.move_toward(Vector3.ZERO, DODGE_SLOWDOWN)

		move_and_slide()

		if velocity == Vector3.ZERO:
			dodging = false

		return

	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, SPEED)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var vertical_input = (
		Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	)

	if vertical_input && !just_dodged:
		velocity.y = move_toward(velocity.y, vertical_input * SPEED, SPEED)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _get_camera_oriented_input() -> Vector3:
	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

	var input := Vector3.ZERO
	# This is to ensure that diagonal input isn't stronger than axis aligned input
	input.x = raw_input.x * sqrt(1.0 - raw_input.y * raw_input.y / 2.0)
	input.z = raw_input.y * sqrt(1.0 - raw_input.x * raw_input.x / 2.0)

	input = camera_mount.global_transform.basis * input
	input.y = 0.0
	return input


func _set_target(new_target: Node3D, collision_point: Vector3):
	target = new_target
	target_collision_point = collision_point

#	if target.is_in_group("destroyable"):
#		target.destroy()


func _on_dodge_cooldown_timer_timeout():
	can_dodge = true
	
		
	
	
