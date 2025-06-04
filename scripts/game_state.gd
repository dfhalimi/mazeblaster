extends Node

var deaths_per_level := {}
var total_deaths := 0

func increase_death_count(level_name: String):
	if not deaths_per_level.has(level_name):
		deaths_per_level[level_name] = 0
	deaths_per_level[level_name] += 1
	total_deaths += 1

func get_death_count(level_name: String) -> int:
	return deaths_per_level.get(level_name, 0)
