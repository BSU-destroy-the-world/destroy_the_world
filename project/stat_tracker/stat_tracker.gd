extends Node3D

signal score_changed(new_score, score_modifier)
signal game_over

var _time = 0
var _last_building_destroyed_time = 0
var _score = 0
var _buildings_count = 0
var _buildings_destroyed = 0


func _process(delta):
	if Input.is_action_just_pressed("debug_restart"):
		_time = 0
		_last_building_destroyed_time = 0
		_score = 0
		_buildings_count = 0
		_buildings_destroyed = 0

	_time += delta
	_last_building_destroyed_time += delta


func add_building():
	_buildings_count += 1
	_time = 0


func building_destroyed():
	_buildings_destroyed += 1

	increase_score()

	if _buildings_destroyed == _buildings_count:
		emit_signal("game_over")

	_last_building_destroyed_time = 0


func increase_score():
	# More buildings destroyed in less time = higher score
	# Less time passed since last building destroyed = higher score
	var score_modifier = 1000
	score_modifier *= 1 + _buildings_destroyed * 0.01
	score_modifier *= max(1, 1 + (5 - _last_building_destroyed_time) / 5)

	score_modifier = round(score_modifier / 10) * 10

	_score += score_modifier

	emit_signal("score_changed", _score, score_modifier)
