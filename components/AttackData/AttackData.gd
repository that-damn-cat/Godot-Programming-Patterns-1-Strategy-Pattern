class_name AttackData
extends Resource

@export_category("Attack Scene")
@export var attack_scene: PackedScene				## The scene to instantiate when performing this attack.
@export var pivot_offset: Vector2					## How much to offset the sprite and hitbox from the attack origin.
@export var movement_strategy: MovementStrategy		## The movement strategy to apply to the attack.

@export_category("Pickup Config")
@export var pickup_icon: Texture2D					## The icon to use for pickups of this attack.
@export var pickup_angle_degrees: float				## The angle to rotate the pickup icon.

@export_category("Attack Data")
@export var attack_sfx: AudioStream					## The sound effect to play when this attack is used.
@export var damage: float							## The damage this attack deals.
@export var piercing: bool							## Whether this attack frees itself on hit.
@export var attack_range: float						## Range of the attack (see invdividual strategies for details)
@export var duration_seconds: float					## The duration in seconds before this attack despawns.
@export var cooldown_seconds: float					## The cooldown in seconds before this attack can be used again.


func _init() -> void:
	resource_local_to_scene = true


func get_attack_scene() -> Attack:
	if not attack_scene:
		return(null)

	var instance := attack_scene.instantiate()
	if not instance is Attack:
		push_error("AttackData.attack_scene must be of type Attack!")
		instance.queue_free()
		return(null)

	return(instance)
