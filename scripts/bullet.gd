extends Area2D

@export var speed := 400.0
var direction := Vector2.RIGHT

func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemies") or body.is_in_group("destructible"):
		body.queue_free()
		
	queue_free()
