class_name ConstantRotationStrategy
extends MovementStrategy

func _get_direction_intent() -> Vector2:
	return(Vector2.ZERO)

func _get_rotation_intent() -> float:
	return(angular_speed)