class_name SlideToTarget
extends MovementStrategy

func _get_direction_intent() -> Vector2:
	_target_player_fallback()

	if not controlled_node or not target_node:
		return(Vector2.ZERO)

	return(controlled_node.global_position.direction_to(target_node.global_position))

func _get_rotation_intent() -> float:
	return(0.0)

func _target_player_fallback() -> void:
	if not target_node:
		target_node = NodeFinder.get_player_node()
