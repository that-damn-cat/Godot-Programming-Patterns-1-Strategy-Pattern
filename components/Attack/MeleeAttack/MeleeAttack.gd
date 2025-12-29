@icon("./plain-dagger.svg")
class_name MeleeAttack
extends Attack

@export var position_root: Node2D
var rotation_speed: float = 0.0    # rad/sec

func _ready() -> void:
	position_root.position.x += spawn_offset

func _process(delta: float) -> void:
	super(delta)

	rotate(rotation_speed * delta)