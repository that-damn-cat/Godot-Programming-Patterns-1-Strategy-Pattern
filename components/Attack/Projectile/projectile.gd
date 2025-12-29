@icon("./broadhead-arrow.svg")
class_name Projectile
extends Attack

var speed: float:
	get:
		return(_speed)
	set(val):
		set_speed(val)
var _speed: float = 100.0


func _ready() -> void:
	hit_box.hit_hurtbox.connect(_on_hitbox_hit)

	if get_parent() != NodeFinder.projectile_container:
		call_deferred("reparent", NodeFinder.projectile_container)

func _process(delta: float) -> void:
	super(delta)

	global_position += Vector2.from_angle(rotation) * speed * delta


func set_speed(new_speed: float) -> void:
	_speed = new_speed


func _on_hitbox_hit(_hurtbox: Hurtbox2D) -> void:
	call_deferred("queue_free")
