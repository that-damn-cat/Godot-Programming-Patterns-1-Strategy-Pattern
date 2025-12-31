class_name Attack
extends Node2D

@export var hit_box: Hitbox2D
@export var sprite: Sprite2D

var movement_strategy: MovementStrategy
var duration_seconds: float = 999.0
var spawn_offset: float = 0.0


func _ready() -> void:
	sprite.position.x += spawn_offset

	if hit_box:
		if not hit_box.is_ancestor_of(sprite):
			hit_box.position.x += spawn_offset

		hit_box.hit_hurtbox.connect(queue_free)

	if duration_seconds > 0.0:
		var despawn_timer := Timer.new()
		despawn_timer.wait_time = duration_seconds
		despawn_timer.autostart = true
		despawn_timer.one_shot = true
		add_child(despawn_timer)
		despawn_timer.timeout.connect(queue_free)

func _process(delta: float) -> void:
	global_position += movement_strategy.velocity * delta
	rotation += movement_strategy.rotation * delta