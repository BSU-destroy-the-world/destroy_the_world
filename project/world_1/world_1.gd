extends Node3D


func _process(_delta):
	if Input.is_action_just_pressed("debug_restart"):
		get_tree().reload_current_scene()
