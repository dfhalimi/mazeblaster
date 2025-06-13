extends Area2D

@export var ammo_amount := 1

func _on_body_entered(body):
	if body.name == "Player":
		GameState.play_ammo_pickup_sound()
		
		body.ammo += ammo_amount
		body.update_ammo_ui()
		queue_free()
