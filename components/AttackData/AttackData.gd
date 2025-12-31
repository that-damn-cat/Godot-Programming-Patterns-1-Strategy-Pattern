class_name AttackData
extends Resource

@export_category("Attack Scene")
@export var attack_scene: PackedScene
@export var pivot_offset: float

@export_category("Pickup Config")
@export var pickup_icon: Texture2D
@export var pickup_angle_degrees: float

@export_category("Attack Data")
@export var attack_sfx: AudioStream
@export var damage: float
@export var attack_range: float
@export var duration_seconds: float
@export var cooldown_seconds: float

var _scene_instance: Attack

func _init() -> void:
	_scene_instance = attack_scene.instantiate()