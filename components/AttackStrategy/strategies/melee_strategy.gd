class_name MeleeStrategy
extends AttackStrategy

@export var weapon_scene: PackedScene
@export_range(0.0, 360.0, 1.0) var range_degrees: float


func attack(attack_origin: Vector2, target: Vector2) -> void:
	# Calculate Rotation Speed (rad/sec)
	var rotation_speed: float = deg_to_rad(range_degrees) / duration_seconds

	# Find Intended Parent
	var parent_node: Node2D
	if is_player_attack:
		parent_node = NodeFinder.get_player_node()
	else:
		parent_node = NodeFinder.get_nearest_enemy(attack_origin)

	var melee_scene: MeleeAttack = weapon_scene.instantiate()
	melee_scene.lifetime_seconds = duration_seconds
	melee_scene.rotation_speed = rotation_speed
	set_attack_collision(melee_scene)

	# Set Starting Position
	melee_scene.global_position = Vector2.ZERO

	# Set Starting Angle
	var angle_to_target = (target - attack_origin).angle()
	melee_scene.rotation = angle_to_target - deg_to_rad(range_degrees / 2.0)

	parent_node.add_child(melee_scene)