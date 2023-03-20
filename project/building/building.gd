extends Node3D

@onready var animation_player := $AnimationPlayer


func _ready():
	if randf() < 0.2:
		destroy()


func destroy():
	animation_player.play("destroy")
