@abstract
class_name Attack
extends Node2D

@export var hit_box: Hitbox2D

var lifetime_seconds: float = 999.0
var _elapsed_lifetime: float = 0.0

@export var spawn_offset: float = 0.0


func _process(delta: float) -> void:
	_elapsed_lifetime += delta
	if _elapsed_lifetime >= lifetime_seconds:
		call_deferred("queue_free")
		return


func set_damage(new_damage: float) -> void:
	hit_box.damage = new_damage

func set_enemy_attack() -> void:
	hit_box.set_collision_layer_value(2, false)
	hit_box.set_collision_layer_value(3, true)

	hit_box.set_collision_mask_value(2, true)
	hit_box.set_collision_mask_value(3, false)

func set_player_attack() -> void:
	hit_box.set_collision_layer_value(2, true)
	hit_box.set_collision_layer_value(3, false)

	hit_box.set_collision_mask_value(2, false)
	hit_box.set_collision_mask_value(3, true)