extends Control

@onready var _completion_label: Label = %CompletionLabel
@onready var _score_label: Label = %ScoreLabel
@onready var _buildings_destroyed_label: Label = %BuildingsDestroyedLabel
@onready var _timer_label: Label = %TimerLabel


func _ready():
	_completion_label.text = (
		"Congratulations!" if StatTracker.get_death_count() == 0 else "Game Over"
	)
	_score_label.text = str(StatTracker.get_score())
	_buildings_destroyed_label.text = (
		str(StatTracker.get_buildings_destroyed()) + "/" + str(StatTracker.get_total_buildings())
	)
	_timer_label.text = str(StatTracker.get_time()) + "s"


func _on_play_again_button_pressed():
	StatTracker.reset()
	get_tree().change_scene_to_file("res://world_1/world_1.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
