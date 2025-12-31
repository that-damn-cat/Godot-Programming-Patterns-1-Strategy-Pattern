@abstract
class_name MovementStrategy
extends Resource

var speed: float

var direction: Vector2:
	get:
		return(get_direction_intent())

var velocity: Vector2:
	get:
		return(direction * speed)

## To be implemented. Should return a normalized direction vector.
@abstract func get_direction_intent() -> Vector2