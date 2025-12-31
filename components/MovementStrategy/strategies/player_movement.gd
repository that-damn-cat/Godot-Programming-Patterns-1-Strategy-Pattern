class_name PlayerMovement
extends MovementStrategy

func _get_direction_intent() -> Vector2:
	var intent := Input.get_vector("left", "right", "up", "down")
	return(intent)

func _get_rotation_intent() -> float:
	return(0.0)