extends Node3D
@onready var particle_Exp = $Particles

# Called when the node enters the scene tree for the first time.
func _ready():
	particle_Exp.emitting = true
