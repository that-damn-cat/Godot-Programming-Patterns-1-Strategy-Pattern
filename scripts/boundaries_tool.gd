@tool
extends StaticBody2D

@export_tool_button("Setup Viewport Boundaries", "Callable") var setup_action = _create_boundary_nodes

func _clear_children() -> void:
	for child in get_children():
		child.queue_free()

func _create_boundary_nodes() -> void:
	_clear_children()

	var node_names = ["Top", "Bottom", "Right", "Left"]

	for this_name in node_names:
		var new_node := CollisionShape2D.new()

		new_node.name = this_name
		new_node = _setup_shape(new_node)

		self.add_child(new_node)
		new_node.owner = get_tree().edited_scene_root

func _setup_shape(input_shape: CollisionShape2D) -> CollisionShape2D:
	var this_shape = WorldBoundaryShape2D.new()

	var viewport_width: float = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height: float = ProjectSettings.get_setting("display/window/size/viewport_height")

	match input_shape.name:
		"Top":
			this_shape.normal = Vector2.DOWN
			input_shape.global_position = Vector2(viewport_width / 2.0, 0.0)
		"Bottom":
			this_shape.normal = Vector2.UP
			input_shape.global_position = Vector2(viewport_width / 2.0, viewport_height)
		"Left":
			this_shape.normal = Vector2.RIGHT
			input_shape.global_position = Vector2(0.0, viewport_height / 2.0)
		"Right":
			this_shape.normal = Vector2.LEFT
			input_shape.global_position = Vector2(viewport_width, viewport_height / 2.0)

	input_shape.shape = this_shape

	return(input_shape)