class_name Player
extends Entity

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack_strategy.attack(self, global_position, get_global_mouse_position())