extends Control

@export var dodge_timer: Timer

@onready var dodge_bar := $MarginContainer/VBoxContainer/DodgeCooldownBar


func _process(_delta):
	if dodge_timer.time_left == 0:
		dodge_bar.value = 100
	else:
		dodge_bar.value = (1 - dodge_timer.time_left / dodge_timer.wait_time) * 100
