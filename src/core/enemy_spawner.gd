class_name EnemySpawner
extends Marker2D

@export var pancake_texture: Texture2D
@export var waffle_texture: Texture2D
@export var enemy_scene: PackedScene

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	SignalBus.toaster_died.connect(_on_toaster_died)

	spawn_timer.wait_time = randf_range(1, 5)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_timer.wait_time = randf_range(1, 5)
	spawn_timer.start()

	var enemy = enemy_scene.instantiate() as Enemy

	var offset = randf_range(-16, 16)
	enemy.global_position = Vector2(global_position.x, global_position.y + offset)
	owner.add_child(enemy)

	if randi_range(1, 2) == 1:
		enemy.sprite.texture = pancake_texture
	else:
		enemy.sprite.texture = waffle_texture


func _on_toaster_died() -> void:
	queue_free()
