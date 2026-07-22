class_name Score
extends Label

var _score = 0


func _ready() -> void:
	SignalBus.enemy_killed.connect(_on_enemy_killed)


func _on_enemy_killed() -> void:
	_score += 100
	text = str(_score).pad_zeros(6)
