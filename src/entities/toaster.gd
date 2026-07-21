class_name Toaster
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 300.0

var _current_direction: float
var _is_loaded: bool


func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("move_up", "move_down")

	if direction and direction != _current_direction:
		_current_direction = direction

	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

	sprite.play(_build_animation_name())


func _build_animation_name() -> String:
	var animation = ""

	if _is_loaded:
		animation = "loaded_"
	else:
		animation = "unloaded_"

	if _current_direction > 0:
		animation += "down"
	else:
		animation += "up"

	return animation
