class_name PlayerMovementStrategy
extends DirectionStrategy

func get_direction_intent() -> Vector2:
	var intent := Input.get_vector("left", "right", "up", "down")
	return(intent)
