extends "res://scripts/enemy.gd"

@export var linked_walls: Array[NodePath] = []

func die():
	for wall_path in linked_walls:
		var wall = get_node_or_null(wall_path)
		if wall:
			wall.queue_free()
	queue_free()
