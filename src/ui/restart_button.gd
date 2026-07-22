class_name RestartButton
extends TextureButton

func _ready() -> void:
	visible = false
	pressed.connect(_on_pressed)
	SignalBus.toaster_died.connect(_on_toaster_died)


func _on_toaster_died() -> void:
	visible = true


func _on_pressed() -> void:
	get_tree().reload_current_scene()
