@abstract
class_name AttackStrategy
extends Resource

@export_category("Attack Stats")
@export var damage: float = 0.0
@export var is_player_attack: bool = true

@export_category("Pickup")
@export var pickup_icon: Texture2D
@export var pickup_rotation_degrees: float

@export_category("SFX")
@export var attack_sfx: AudioStream
var sfx_player: AudioStreamPlayer:
	get:
		return(_sfx_player)
	set(new_player):
		update_sfx_player(new_player)
var _sfx_player: AudioStreamPlayer

@export_category("Timing")
@export var cooldown_seconds: float = 0.0
var _cooldown_time_elapsed: float = INF

@export var duration_seconds: float = INF

func try_attack(attack_origin: Vector2, attack_target: Vector2) -> void:
	if _cooldown_time_elapsed >= cooldown_seconds:
		attack(attack_origin, attack_target)
		_cooldown_time_elapsed = 0.0
		if sfx_player:
			sfx_player.play()

func update(delta: float) -> void:
	_cooldown_time_elapsed += delta

func update_sfx_player(new_player: AudioStreamPlayer) -> void:
	_sfx_player = new_player

	if _sfx_player == null:
		return

	if attack_sfx:
		sfx_player.stream = attack_sfx
	else:
		sfx_player.stream = null

@abstract func attack(attack_origin: Vector2, attack_target: Vector2) -> void

func set_attack_collision(this_attack: Attack):
	if is_player_attack:
		this_attack.set_player_attack()
	else:
		this_attack.set_enemy_attack()