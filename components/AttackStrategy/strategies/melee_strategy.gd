class_name MeleeStrategy
extends AttackStrategy

func _perform_attack(attacker: Node2D, origin: Vector2, target: Vector2) -> void:
	var attack_scene: Attack = attack_data.get_attack_scene()

	if attack_scene == null:
		return

	# Configure movement
	attack_scene.movement_strategy = attack_data.movement_strategy.duplicate()

	# Calculate rotation speed required
	var attack_range: float = clamp(attack_data.attack_range, 0.0, 360.0)
	var rotation_speed: float = deg_to_rad(attack_range) / attack_data.duration_seconds
	attack_scene.movement_strategy.controlled_node = attack_scene
	attack_scene.movement_strategy.angular_speed = rotation_speed

	# Set other requirements
	_set_collision(attacker, attack_scene.hit_box)
	attack_scene.duration_seconds = attack_data.duration_seconds
	attack_scene.hit_box.damage = attack_data.damage
	attack_scene.spawn_offset = attack_data.pivot_offset

	var angle_to_target = (target - origin).angle()
	attack_scene.rotation = angle_to_target - deg_to_rad(attack_data.attack_range / 2.0)

	# Spawn it
	attacker.add_child(attack_scene)
	attack_scene.global_position = origin