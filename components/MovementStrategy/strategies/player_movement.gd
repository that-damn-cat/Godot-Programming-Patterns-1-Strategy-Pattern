class_name PlayerMovementStrategy
extends MovementStrategy

func _get_direction_intent() -> Vector2:
	var intent := Input.get_vector("left", "right", "up", "down")
	return(intent)

func get_rotation(_delta: float) -> float:
	return(0.0)