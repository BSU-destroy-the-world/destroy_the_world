extends Node3D
@onready var particle_Exp = $Particles
@onready var audio_player := $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	particle_Exp.emitting = true
	audio_player.play(0)
