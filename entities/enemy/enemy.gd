class_name Enemy
extends Entity

func _on_die() -> void:
	%StateMachine.enabled = false
	%Hurtbox2D.set_deferred("monitoring", false)
	%Hurtbox2D.set_deferred("monitorable", false)
	%PlayerChaseArea.set_deferred("monitoring", false)
	%PlayerChaseArea.set_deferred("monitorable", false)

func _on_death_anim_finished() -> void:
	queue_free()