@abstract
class_name DirectionStrategy
extends Resource

var direction: Vector2:
	get:
		return(get_direction_intent())

## To be implemented.
@abstract func get_direction_intent() -> Vector2