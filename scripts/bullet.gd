extends Area2D

@export var speed := 400.0
var direction := Vector2.RIGHT

func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.die()
	elif body.is_in_group("destructible"):
		GameState.play_wall_break_sound()
		body.queue_free()
	elif body.is_in_group("walls"):
		GameState.play_wall_hit_sound()
	queue_free()
