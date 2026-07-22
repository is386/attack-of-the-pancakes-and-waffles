class_name HealthBar
extends HBoxContainer

func _ready() -> void:
	SignalBus.damage_taken.connect(_on_damage_taken)


func _on_damage_taken() -> void:
	if get_child_count() == 0:
		return
	(get_children().back() as Control).queue_free()
