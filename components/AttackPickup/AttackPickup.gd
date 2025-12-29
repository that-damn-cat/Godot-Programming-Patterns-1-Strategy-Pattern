@tool
class_name AttackPickup
extends Area2D

const NO_ATTACK: AttackStrategy = preload("res://attacks/no_attack.tres")

@export var attack_strategy: AttackStrategy:
	get:
		return(_attack_strategy)
	set(new_strategy):
		update_strategy(new_strategy)
var _attack_strategy: AttackStrategy

@export_category("Hover Effect")
@export var hover_amplitude: float = 6.0
@export var cycles_per_second: float = 4.0

var _time_elapsed: float = randf_range(0.0, TAU)
var _pickup_sprite: Sprite2D

func _ready() -> void:
	_update_pickup_sprite()

	if Engine.is_editor_hint():
		return

	if attack_strategy == null:
		push_warning("Attack Pickup has no Attack Strategy")
		attack_strategy = NO_ATTACK

	update_strategy(attack_strategy)
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	_time_elapsed += delta
	_pickup_sprite.position.y = sin(_time_elapsed * cycles_per_second) * hover_amplitude


func update_strategy(this_strategy: AttackStrategy) -> void:
	if _pickup_sprite == null:
		_update_pickup_sprite()

	if _pickup_sprite == null:
		return

	if this_strategy == null:
		this_strategy = NO_ATTACK

	_attack_strategy = this_strategy

	var new_texture: Texture2D

	if this_strategy != null:
		if this_strategy.pickup_icon != null:
			new_texture = this_strategy.pickup_icon

	_pickup_sprite.texture = new_texture
	_pickup_sprite.scale = Vector2(2.0, 2.0)
	_pickup_sprite.rotation_degrees = this_strategy.pickup_rotation_degrees

func _update_pickup_sprite() -> void:
	_pickup_sprite = find_child("PickupSprite")

func _on_body_entered(body: Node2D) -> void:
	if Engine.is_editor_hint():
		return

	if not body is Player:
		return

	if body.attack_strategy == attack_strategy:
		return

	var body_old_attack = body.attack_strategy
	body.attack_strategy = attack_strategy

	if body_old_attack == NO_ATTACK:
		queue_free()
	else:
		attack_strategy = body_old_attack
