extends State

@export var hitstun_time: float = 0.5

var remaining_time: float = 0.0

var _hurt_anim_finished: bool

func enter() -> void:
	var _entity: Entity = state_machine.controlled_node
	_entity.movement_controller = Constants.NULL_MOVEMENT_STRATEGY
	remaining_time = hitstun_time
	_hurt_anim_finished = false

func update(delta: float) -> void:
	remaining_time -= delta
	if remaining_time <= 0.0 and _hurt_anim_finished:
		state_machine.current_state = state_machine.previous_state

func _on_hurt_animation_finished() -> void:
	_hurt_anim_finished = true