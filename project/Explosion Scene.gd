extends Node3D
@onready var particle_Exp = $CPUParticles3D3
@onready var particle_1 = $CPUParticles3D2
@onready var particle_2 = $CPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	particle_Exp.emitting = true
	particle_1.emitting = true
	particle_2.emitting = true
