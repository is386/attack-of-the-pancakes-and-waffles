class_name Enemy
extends AnimatableBody2D

@export var speed: float = 100

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health_component: HealthComponent = $HealthComponent
@onready var hitbox: Hitbox = $Hitbox


func _ready() -> void:
	hurtbox.hurt.connect(_on_hurt)
	hitbox.hit.connect(_on_hit)
	health_component.died.connect(_on_died)


func _physics_process(delta: float) -> void:
	global_position.x -= delta * speed


func _on_hurt(_hitbox: Hitbox) -> void:
	health_component.take_damage(_hitbox.damage)


func _on_hit(_hurtbox: Hurtbox) -> void:
	queue_free()


func _on_died() -> void:
	queue_free()
