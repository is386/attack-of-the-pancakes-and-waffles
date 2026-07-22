class_name Toast
extends AnimatableBody2D

@export var speed: float = 100

@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hitbox: Hitbox = $Hitbox


func _ready() -> void:
	screen_notifier.screen_exited.connect(_on_screen_exited)
	hitbox.hit.connect(_on_hit)


func _physics_process(delta: float) -> void:
	global_position.x += delta * speed


func _on_screen_exited() -> void:
	queue_free()


func _on_hit(_hurtbox: Hurtbox) -> void:
	queue_free()
