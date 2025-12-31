class_name Attack
extends Node2D

@export var hit_box: Hitbox2D
@export var sprite: Sprite2D

var movement_strategy: MovementStrategy
var duration_seconds: float = 999.0
var spawn_offset: float = 0.0
var origin: Vector2 = Vector2.ZERO
var max_distance: float = 0.0


func _ready() -> void:
	sprite.position.x += spawn_offset

	if hit_box:
		if not hit_box.is_ancestor_of(sprite):
			hit_box.position.x += spawn_offset

		hit_box.hit_hurtbox.connect(queue_free)

	_setup_despawn_timer(duration_seconds)

func _process(delta: float) -> void:
	global_position += movement_strategy.velocity * delta
	rotation += movement_strategy.rotation * delta

	if _exceeded_distance():
		queue_free()


func _exceeded_distance() -> bool:
	if max_distance <= 0.0:
		return false

	var distance = global_position.distance_to(origin)
	return(distance > max_distance)

func _setup_despawn_timer(duration: float) -> void:
	if duration_seconds == INF or duration_seconds <= 0.0:
		return

	var despawn_timer := Timer.new()
	despawn_timer.wait_time = duration
	despawn_timer.autostart = true
	despawn_timer.one_shot = true
	add_child(despawn_timer)
	despawn_timer.timeout.connect(queue_free)