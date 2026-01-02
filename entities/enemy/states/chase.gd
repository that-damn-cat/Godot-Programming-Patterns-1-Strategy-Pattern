extends State

@export var chase_speed: float = 150.0

var _chase_movement_strategy: SlideToTarget
var _entity: Entity

func _ready() -> void:
	super()
	_entity = state_machine.controlled_node
	_chase_movement_strategy = SlideToTarget.new(_entity, NodeFinder.get_player_node())

## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	_entity.movement_strategy = _chase_movement_strategy
	_entity.speed = chase_speed

func set_chase_target(target: Node2D) -> void:
	if target == null:
		target = NodeFinder.get_player_node()

	_entity.movement_strategy.target_node = target
