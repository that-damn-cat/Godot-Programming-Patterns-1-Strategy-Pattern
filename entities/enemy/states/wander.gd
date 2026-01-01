extends State

@export var idle_time_range := Vector2(0.5, 2.5)
@export var wander_time_range := Vector2(0.4, 1.6)
@export var wander_speed := 100.0
@export var wander_marker: Marker2D

var is_idle: bool = true
var remaining_time: float = 0.0

var _entity: Entity
var _wander_movement_strategy: SlideToTarget

func _ready() -> void:
	super()
	_entity = state_machine.controlled_node
	_wander_movement_strategy = SlideToTarget.new(_entity, wander_marker, wander_speed)

## To be implemented by the inheriting node. Called when the state is first entered.
func enter() -> void:
	_set_idle()

## To be implemented by the inheriting node. Called with _process
func update(delta: float) -> void:
	remaining_time -= delta
	if remaining_time <= 0.0:
		if is_idle:
			_set_wander()
		else:
			_set_idle()


func _set_idle() -> void:
	_entity.movement_controller = Constants.NULL_MOVEMENT_STRATEGY
	is_idle = true
	remaining_time = randf_range(idle_time_range.x, idle_time_range.y)

func _set_wander() -> void:
	var random_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * wander_speed * 5.0
	wander_marker.global_position = _entity.global_position + random_offset
	_entity.movement_controller = _wander_movement_strategy
	is_idle = false
	remaining_time = randf_range(wander_time_range.x, wander_time_range.y)
