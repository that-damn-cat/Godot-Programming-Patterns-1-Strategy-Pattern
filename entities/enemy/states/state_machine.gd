extends StateMachine

var players_in_range: int = 0

func _on_player_chase_body_entered(body: Node2D) -> void:
	players_in_range += 1
	if body is Player:
		change_state("chase")
		states["chase"].set_chase_target(body)

func _on_player_chase_body_exited(body: Node2D) -> void:
	if body is Player:
		players_in_range -= 1

	if players_in_range <= 0:
		change_state("wander")

func _on_health_damaged(_amount: float) -> void:
	change_state("hitstun")
