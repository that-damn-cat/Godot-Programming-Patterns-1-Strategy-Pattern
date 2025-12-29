extends Node

var game_node: Game
var projectile_container: Node
var enemy_container: Node
var player_node: Player

func _ready() -> void:
	get_game_node()
	get_projectile_container()
	get_enemy_container()
	get_player_node()

func get_game_node() -> Game:
	if is_instance_valid(game_node):
		return(game_node)

	game_node = get_tree().get_first_node_in_group("Game")

	return(game_node)

func get_projectile_container() -> Node:
	if is_instance_valid(projectile_container):
		return(projectile_container)

	if game_node == null:
		get_game_node()

	projectile_container = game_node.projectile_container

	return(projectile_container)

func get_enemy_container() -> Node:
	if is_instance_valid(enemy_container):
		return(enemy_container)

	if game_node == null:
		get_game_node()

	enemy_container = game_node.enemy_container

	return(enemy_container)

func get_nearest_enemy(position: Vector2) -> Node:
	if not is_instance_valid(enemy_container):
		get_enemy_container()

	var enemies: Array[Node2D] = []

	for child in enemy_container.get_children():
		if child is Node2D:
			enemies.append(child)

	if enemies.size() == 0:
		return(null)

	var nearest: Node2D = enemies[0]
	for child in enemies:
		if child.global_position == position:
			return(child)

		if position.distance_to(child.global_position) < position.distance_to(nearest.global_position):
			nearest = child

	return(nearest)

func get_player_node() -> Player:
	if is_instance_valid(player_node):
		return(player_node)

	player_node = get_tree().get_first_node_in_group("Player")

	return(player_node)