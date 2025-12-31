@abstract
class_name AttackStrategy
extends Resource

@export var attack_data: AttackData

var _next_attack_time: float = 0.0


func _init() -> void:
	resource_local_to_scene = true


func attack(attacker: Node2D, origin: Vector2, target: Vector2) -> void:
	var now = Time.get_ticks_msec() * 0.001

	if now < _next_attack_time:
		return

	_next_attack_time = now + attack_data.cooldown_seconds
	_perform_attack(attacker, origin, target)
	_play_sfx(attacker)


func _play_sfx(attacker: Node2D) -> void:
	if attack_data.attack_sfx == null:
		return

	var sfx_player := AudioStreamPlayer.new()
	sfx_player.stream = attack_data.attack_sfx
	attacker.add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)

func _set_collision(attacker: Node2D, hitbox: Hitbox2D) -> void:
	if attacker is Player:
		_set_player_attack(hitbox)
	else:
		_set_enemy_attack(hitbox)

func _set_player_attack(collider: Area2D) -> void:
	collider.set_collision_layer_value(2, true)
	collider.set_collision_layer_value(3, false)

	collider.set_collision_mask_value(2, false)
	collider.set_collision_mask_value(3, true)

func _set_enemy_attack(collider: Area2D) -> void:
	collider.set_collision_layer_value(2, false)
	collider.set_collision_layer_value(3, true)

	collider.set_collision_mask_value(2, true)
	collider.set_collision_mask_value(3, false)

@abstract func _perform_attack(attacker: Node2D, origin: Vector2, target: Vector2) -> void