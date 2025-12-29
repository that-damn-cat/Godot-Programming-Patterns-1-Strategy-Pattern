class_name RangedStrategy
extends AttackStrategy

@export var projectile_scene: PackedScene
@export var accuracy: float = 1.0
@export var speed: float = 100.0

func attack(attack_origin: Vector2, target: Vector2) -> void:
	# Create projectile
	var new_projectile = projectile_scene.instantiate() as Projectile

	# Determine rotation
	accuracy = clamp(accuracy, 0.0, 1.0)
	var max_spread = remap(accuracy, 0.0, 1.0, PI, 0.0)
	var accuracy_offset: float = randf_range(-max_spread, max_spread)

	var angle_to_target = (target - attack_origin).angle()

	new_projectile.rotation = angle_to_target + accuracy_offset

	# Determine Position
	var origin_offset: float = new_projectile.get("spawn_offset")
	new_projectile.global_position = attack_origin
	if origin_offset != null:
		new_projectile.global_position += (target - attack_origin).normalized() * origin_offset

	# Set Damage
	if new_projectile.has_method("set_damage"):
		new_projectile.set_damage(damage)
	else:
		push_warning("Projectile missing set_damage!")

	# Set Speed
	if new_projectile.has_method("set_speed"):
		new_projectile.set_speed(speed)
	else:
		push_warning("Projectile missing set_speed!")

	# Set Collision Type
	set_attack_collision(new_projectile)

	# Set Free Timer
	new_projectile.lifetime_seconds = duration_seconds

	# Add to tree
	var container: Node = NodeFinder.get_projectile_container()
	container.add_child(new_projectile)
