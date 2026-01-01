class_name RangedStrategy
extends AttackStrategy

@export var speed: float = 200.0
@export_range(0.0, 1.0, 0.01) var accuracy: float = 1.0

func _perform_attack(attacker: Node2D, origin: Vector2, target: Vector2) -> void:
	var projectile: Attack = attack_data.get_attack_scene()

	# Configure movement
	projectile.movement_strategy = attack_data.movement_strategy.duplicate()

	# Set Speed
	projectile.movement_strategy.controlled_node = projectile
	projectile.movement_strategy.speed = speed

	# Set other requirements
	_set_collision(attacker, projectile.hit_box)
	projectile.duration_seconds = attack_data.duration_seconds
	projectile.hit_box.damage = attack_data.damage
	projectile.origin = origin
	projectile.max_distance = attack_data.attack_range

	# Determine rotation and starting position
	accuracy = clamp(accuracy, 0.0, 1.0)
	var max_spread = remap(accuracy, 0.0, 1.0, PI, 0.0)
	var accuracy_offset: float = randf_range(-max_spread, max_spread)
	var angle_to_target = (target - origin).angle()
	projectile.rotation = angle_to_target + accuracy_offset
	projectile.scale = attacker.scale
	projectile.spawn_offset = attack_data.pivot_offset

	# Spawn it
	var container: Node = NodeFinder.get_projectile_container()
	container.add_child(projectile)
	projectile.global_position = origin