extends CharacterBody2D

@export var speed := 100.0
@export var patrol_distance := 100.0

var direction := Vector2.RIGHT
var start_position := Vector2.ZERO

func _ready():
	start_position = position

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

	# Flip on wall collision
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_normal().x != 0:
			_flip_direction()
			return

	# Flip if patrol distance exceeded
	if abs(position.x - start_position.x) > patrol_distance:
		_flip_direction()

func _flip_direction():
	direction.x *= -1
	start_position = position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().reload_current_scene()
