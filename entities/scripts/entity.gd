class_name Entity
extends CharacterBody2D

@export_category("Movement")
@export var movement_controller: MovementStrategy
@export var starting_speed: float = 200.0

var speed: float:
	get:
		return(_speed)
	set(new_speed):
		_update_speed(new_speed)
var _speed: float

@export_category("Attacks")
@export var starting_attack: AttackStrategy

var attack_strategy: AttackStrategy:
	get:
		return(_attack_strategy)
	set(new_strategy):
		_update_strategy(new_strategy)
var _attack_strategy

func _ready() -> void:
	_update_strategy(starting_attack)
	_update_speed(starting_speed)

func _physics_process(delta: float) -> void:
	velocity = movement_controller.velocity
	rotation += movement_controller.rotation * delta
	move_and_slide()

func _update_strategy(new_strategy: AttackStrategy):
	if new_strategy == null:
		new_strategy = Constants.NULL_ATTACK_STRATEGY

	_attack_strategy = new_strategy

func _update_speed(new_speed: float) -> void:
	_speed = new_speed
	movement_controller.speed = _speed
