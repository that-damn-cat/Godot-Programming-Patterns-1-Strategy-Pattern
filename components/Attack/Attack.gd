class_name Attack
extends Node2D

@export var hit_box: Hitbox2D
@export var sprite: Sprite2D
@export var movement_strategy: MovementStrategy

var duration_seconds: float = 999.0
var spawn_offset := Vector2.ZERO
var origin := Vector2.ZERO
var max_distance: float = 0.0
var piercing: bool = false

func _ready() -> void:
	if not hit_box or not sprite:
		push_error("Attack node missing required child nodes.")
		queue_free()

	sprite.position += spawn_offset * scale

	if not hit_box.is_ancestor_of(sprite):
		hit_box.position += spawn_offset * scale

	if not piercing:
		hit_box.hit_hurtbox.connect(_on_hitbox_hit)
	_setup_despawn_timer(duration_seconds)

func _process(_delta: float) -> void:
	if _exceeded_distance():
		queue_free()

func _physics_process(delta: float) -> void:
	if movement_strategy == null:
		movement_strategy = Constants.NULL_MOVEMENT_STRATEGY

	global_position += movement_strategy.velocity * delta
	rotation += movement_strategy.rotation * delta


func _exceeded_distance() -> bool:
	if max_distance <= 0.0:
		return false

	var distance = global_position.distance_to(origin)
	return(distance > max_distance)

func _setup_despawn_timer(duration: float) -> void:
	if duration == INF or duration <= 0.0:
		return

	var despawn_timer := Timer.new()
	despawn_timer.wait_time = duration
	despawn_timer.autostart = true
	despawn_timer.one_shot = true
	add_child(despawn_timer)
	despawn_timer.timeout.connect(queue_free)

func _on_hitbox_hit(_hurtbox: Hurtbox2D) -> void:
	queue_free()