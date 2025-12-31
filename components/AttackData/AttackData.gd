class_name AttackData
extends Resource

@export_category("Attack Scene")
@export var attack_scene: PackedScene
@export var pivot_offset: float
@export var movement_strategy: MovementStrategy

@export_category("Pickup Config")
@export var pickup_icon: Texture2D
@export var pickup_angle_degrees: float

@export_category("Attack Data")
@export var attack_sfx: AudioStream
@export var damage: float
@export var attack_range: float
@export var duration_seconds: float
@export var cooldown_seconds: float


func _get_attack_scene() -> Attack:
	var instance := attack_scene.instantiate()
	if not instance is Attack:
		push_error("AttackData.attack_scene must be of type Attack!")
		instance.queue_free()
		return(null)

	return(instance)