extends "res://scripts/enemy.gd"

@export var linked_walls: Array[NodePath] = []

func die():
	GameState.play_enemy_hit_sound()
	for wall_path in linked_walls:
		var wall = get_node_or_null(wall_path)
		if wall:
			GameState.play_trigger_wall_disappear_sound()
			wall.queue_free()
	queue_free()
