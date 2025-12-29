A small demo project showing an example of the Strategy Pattern implemented in Godot/GDScript

The Player has two Strategies -- 

A movement controller (strategy) that returns a direction in physics_process
`func _physics_process(_delta: float) -> void:
	velocity = movement_controller.direction * speed
	move_and_slide()`

An attack strategy that the player can call `update` and `try_attack` on
`func _process(delta: float) -> void:
	if attack_strategy == null:
		attack_strategy = NO_ATTACK
	attack_strategy.update(delta)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack_strategy.try_attack(global_position, get_viewport().get_mouse_position())`

There is one concrete implementation of MovementStrategy (PlayerMovementStrategy) and three concrete implementations of AttackStrategy (`RangedAttackStrategy`, `MeleeAttackStrategy`, and `NullAttackStrategy`)
The attack strategies are extended from `Resource`, and so new versions of these concrete impmenetations can be made as resources. This project contains two Ranged and two Melee options.

This project also demonstrates how flexible Strategies can be. There is a generic Weapon Pickup object which can accept an Attack Strategy, and will provide the player with that attack when they collect it. The player's old strategy (if any) will drop to the ground in its place.
