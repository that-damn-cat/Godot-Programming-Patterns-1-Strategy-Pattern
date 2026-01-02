@tool
class_name HealthBar
extends Control

@export_category("Configuration")
@export var health: HealthComponent:
	set(new_health_component):
		_update_bar_extents()
		_update_health_signals(new_health_component)
		health = new_health_component

@export var origin_node: Node2D:
	set(new_origin):
		origin_node = new_origin
		_update_offset()

@export_category("Appearance")
@export var bar_color: Color = Color.GREEN:
	get:
		return _bar_color
	set(value):
		_update_bar_color(value)
var _bar_color: Color = Color.GREEN

@export var v_offset: float = 0.0:
	set(value):
		v_offset = value
		_update_offset()

@export var bar_size: Vector2 = Vector2(40.0, 5.0):
	set(value):
		_update_bar_size(value)
		bar_size = value

@export_category("Behavior")
@export var hide_if_full: bool = true
@export var hide_if_empty: bool = true

var _progress_bar: ProgressBar = null


func _ready() -> void:
	_update_progress_bar()
	_update_all()

	if Engine.is_editor_hint():
		return

	if hide_if_full and health.is_full:
		hide()

func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		_update_progress_bar()


func _update_all() -> void:
	if _progress_bar == null or not is_inside_tree():
		return

	_update_bar_color(bar_color)
	_update_bar_extents()
	_update_bar_size(bar_size)
	_update_offset()
	_update_health_signals(health)

func _update_bar_color(value: Color) -> void:
	_bar_color = value

	if _progress_bar == null:
		return

	var stylebox: StyleBox = _progress_bar.get_theme_stylebox("fill")
	if stylebox == null:
		return

	stylebox = stylebox.duplicate()
	stylebox.bg_color = _bar_color
	_progress_bar.add_theme_stylebox_override("fill", stylebox)

func _update_bar_extents() -> void:
	if _progress_bar == null:
		_update_progress_bar()

	if health == null:
		_progress_bar.max_value = 100.0
		_progress_bar.value = 50.0
		return

	_progress_bar.min_value = health.min_value
	_progress_bar.max_value = health.max_value

	if health.get("value") == null:
		_progress_bar.value = (health.max_value - health.min_value) / 2.0
	else:
		_progress_bar.value = health.value

func _update_bar_size(value: Vector2) -> void:
	if origin_node == null:
		return

	if _progress_bar == null:
		_update_progress_bar()

	_progress_bar.custom_minimum_size = value * origin_node.scale

func _update_offset() -> void:
	if origin_node == null:
		return

	global_position = origin_node.global_position + Vector2(0.0, v_offset) * origin_node.scale

func _update_health_signals(new_health_component: HealthComponent) -> void:
	if health != null:
		health.disconnect("changed", _on_health_changed)

	if new_health_component != null:
		new_health_component.connect("changed", _on_health_changed)

func _update_progress_bar() -> void:
	var progress_bars := find_children("*", "ProgressBar", true, false)
	if progress_bars.size() == 0:
		_progress_bar = null
		return

	_progress_bar = progress_bars[0]
	_update_all()

func _on_health_changed(_delta: float) -> void:
	if _progress_bar == null:
		_update_progress_bar()

	_progress_bar.value = health.value

	if Engine.is_editor_hint():
		return

	if hide_if_full and health.is_full:
		hide()
	elif hide_if_empty and health.is_empty:
		hide()
	else:
		show()
