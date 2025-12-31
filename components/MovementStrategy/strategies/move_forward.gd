class_name ForwardMovement
extends MovementStrategy

func _get_direction_intent() -> Vector2:
	if not controlled_node:
		return(Vector2.ZERO)

	return(Vector2.RIGHT.rotated(controlled_node.rotation))

func _get_rotation_intent() -> float:
	return(0.0)