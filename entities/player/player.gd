class_name Player
extends CharacterBody2D

const NO_ATTACK: AttackStrategy = preload("res://attacks/no_attack.tres")

@export var movement_controller: DirectionStrategy
@export var speed: float = 200.0
@export var starting_attack: AttackStrategy

var attack_strategy: AttackStrategy:
	get:
		return(_attack_strategy)
	set(new_strategy):
		update_strategy(new_strategy)
var _attack_strategy

var sfx_player: AudioStreamPlayer

func _ready() -> void:
	sfx_player = %ShootSFX
	attack_strategy = starting_attack

func _process(delta: float) -> void:
	if attack_strategy == null:
		attack_strategy = NO_ATTACK

	attack_strategy.update(delta)

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack_strategy.try_attack(global_position, get_viewport().get_mouse_position())

func _physics_process(_delta: float) -> void:
	velocity = movement_controller.direction * speed
	move_and_slide()

func update_strategy(new_strategy: AttackStrategy):
	if new_strategy == null:
		new_strategy = NO_ATTACK

	_attack_strategy = new_strategy
	new_strategy.sfx_player = sfx_player
