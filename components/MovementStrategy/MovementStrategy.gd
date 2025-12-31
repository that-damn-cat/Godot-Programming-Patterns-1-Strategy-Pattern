@abstract
class_name MovementStrategy
extends Resource

## Origin node, if needed
var controlled_node: Node2D

## Pixels per second
var speed: float = 0.0

## Radians per second
var angular_speed: float = 0.0

## Radians to rotate (no delta)
var rotation: float:
	get:
		return(_get_rotation_intent())

## Normalized direction Vector
var direction: Vector2:
	get:
		return(_get_direction_intent())

## Direction * speed (no delta)
var velocity: Vector2:
	get:
		return(direction * speed)

func _init() -> void:
	resource_local_to_scene = true

## Should return a normalized direction vector.
@abstract func _get_direction_intent() -> Vector2

## Should return a change in rotation in radians
@abstract func _get_rotation_intent() -> float