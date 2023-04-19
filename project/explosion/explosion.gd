extends Node3D

@onready var animation_player = $AnimationPlayer
# @onready var


func _ready():
	animation_player.play("explode")
