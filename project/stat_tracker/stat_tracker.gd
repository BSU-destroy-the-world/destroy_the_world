extends Node3D

signal score_changed(new_score, score_modifier)
signal game_over

var _time := 0.0
var _last_building_destroyed_time := 0.0
var _score := 0
var _buildings_count := 0
var _buildings_destroyed := 0
var _death_count := 0
var _game_over := false

@onready var _game_over_screen := preload("res://game_over_screen/game_over_screen.tscn")


func _process(delta):
	if Input.is_action_just_pressed("debug_restart"):
		reset()

	_time += delta
	_last_building_destroyed_time += delta


func reset():
	_time = 0
	_last_building_destroyed_time = 0
	_score = 0
	_buildings_count = 0
	_buildings_destroyed = 0
	_death_count = 0
	_game_over = false


func get_death_count() -> int:
	return _death_count


func get_score() -> int:
	return _score


func get_total_buildings() -> int:
	return _buildings_count


func get_buildings_destroyed() -> int:
	return _buildings_destroyed


func get_time() -> int:
	return roundi(_time)


func add_building():
	_buildings_count += 1


func building_destroyed():
	_buildings_destroyed += 1

	increase_score()

	if _buildings_destroyed == _buildings_count:
		_load_game_over_screen()

	_last_building_destroyed_time = 0


func increase_score():
	# More buildings destroyed in less time = higher score
	# Less time passed since last building destroyed = higher score
	var score_modifier = 1000
	score_modifier *= 1 + _buildings_destroyed * 0.01
	score_modifier *= max(1, 1 + (5 - _last_building_destroyed_time) / 5.0)

	score_modifier = round(score_modifier / 10) * 10

	_score += score_modifier

	emit_signal("score_changed", _score, score_modifier)


func add_death():
	_death_count += 1

	_load_game_over_screen()


func _load_game_over_screen():
	emit_signal("game_over")
	get_tree().change_scene_to_packed(_game_over_screen)
