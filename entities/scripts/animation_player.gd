extends AnimationPlayer

signal hurt_anim_finished
signal death_anim_finished

@export var body: CharacterBody2D

var facing_right: bool = true
var _anim_overridden: bool = false


func _process(_delta: float) -> void:
	if _anim_overridden:
		return

	if body.velocity.length() == 0:
		if facing_right:
			play("idle_right")
		else:
			play("idle_left")

		return

	facing_right = body.velocity.x > 0

	if facing_right:
		play("walk_right")
	else:
		play("walk_left")


func _on_damaged(_amount: float) -> void:
	if _anim_overridden:
		return

	if facing_right:
		play("hurt_right")
	else:
		play("hurt_left")

	_anim_overridden = true
	await animation_finished
	_anim_overridden = false
	hurt_anim_finished.emit()

func _on_death() -> void:
	if facing_right:
		play("death_right")
	else:
		play("death_left")

	_anim_overridden = true
	await animation_finished
	_anim_overridden = false
	death_anim_finished.emit()