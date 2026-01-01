class_name HomeToTarget
extends MovementStrategy

func _get_direction_intent() -> Vector2:
	if not controlled_node or not target_node:
		return(Vector2.ZERO)

	return(Vector2.RIGHT.rotated(controlled_node.rotation))

func _get_rotation_intent() -> float:
	_target_player_fallback()

	if not controlled_node or not target_node:
		return(0.0)

	var desired_angle: float = (target_node.global_position - controlled_node.global_position).angle()
	var angle_diff: float = angle_difference(controlled_node.global_rotation, desired_angle)

	if abs(angle_diff) < deg_to_rad(1.0):
		return(0.0)

	return(angular_speed * sign(angle_diff))


func _target_player_fallback() -> void:
	if not target_node:
		target_node = NodeFinder.get_player_node()
