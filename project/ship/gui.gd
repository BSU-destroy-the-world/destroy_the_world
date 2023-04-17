extends Control

@export var dodge_timer: Timer

@onready var dodge_bar := %DodgeCooldownBar
@onready var score_label := %ScoreLabel


func _ready():
	StatTracker.connect("score_changed", _on_score_changed)


func _process(_delta):
	if dodge_timer.time_left == 0:
		dodge_bar.value = 100
	else:
		dodge_bar.value = (1 - dodge_timer.time_left / dodge_timer.wait_time) * 100


func _on_score_changed(new_score, _score_modifier):
	score_label.text = str(new_score)
