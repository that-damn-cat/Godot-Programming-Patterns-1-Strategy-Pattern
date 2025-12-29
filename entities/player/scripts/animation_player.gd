extends AnimationPlayer

@export var body: CharacterBody2D

var facing_right: bool = true

func _process(_delta: float) -> void:
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
