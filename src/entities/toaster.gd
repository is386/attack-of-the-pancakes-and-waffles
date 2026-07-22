class_name Toaster
extends CharacterBody2D

@export var speed = 300.0
@export var toast_packed_scene: PackedScene

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var toast_sprite: Sprite2D = $Toast
@onready var shoot_timer: Timer = $ShootTimer
@onready var charge_timer: Timer = $ChargeTimer

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health_component: HealthComponent = $HealthComponent

var _current_direction: float
var _is_loaded: bool
var _is_charged: bool


func _ready() -> void:
	_is_loaded = true
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	charge_timer.timeout.connect(_on_charge_timer_timeout)
	hurtbox.hurt.connect(_on_hurt)
	health_component.died.connect(_on_died)


func _physics_process(_delta: float) -> void:
	sprite.play(_build_animation_name())
	toast_sprite.visible = _is_loaded

	if _is_loaded and not _is_charged and not Input.is_action_pressed("shoot"):
		_is_charged = false
		charge_timer.stop()
	elif _is_loaded and _is_charged:
		_shoot()
	elif _is_loaded and Input.is_action_just_pressed("shoot"):
		_shoot()
	elif not _is_charged and charge_timer.is_stopped() and Input.is_action_pressed("shoot"):
		charge_timer.start()

	var direction = Input.get_axis("move_up", "move_down")

	if direction and direction != _current_direction:
		_current_direction = direction

	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()


func _on_shoot_timer_timeout() -> void:
	_is_loaded = true


func _on_charge_timer_timeout() -> void:
	_is_charged = true


func _on_hurt(hitbox: Hitbox) -> void:
	health_component.take_damage(hitbox.damage)
	SignalBus.damage_taken.emit()


func _on_died() -> void:
	SignalBus.toaster_died.emit()
	queue_free()


func _shoot() -> void:
	var toast = toast_packed_scene.instantiate() as Toast
	toast.global_position = global_position
	toast.is_burnt = _is_charged
	owner.add_child.call_deferred(toast)

	_is_charged = false
	_is_loaded = false
	shoot_timer.start()


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
