extends CharacterBody2D

@export var speed := 100.0
@export var patrol_distance := 100.0

enum Direction { LEFT, RIGHT, UP, DOWN }
@export var initial_direction: Direction = Direction.RIGHT

var direction := Vector2.ZERO
var start_position := Vector2.ZERO

func _ready():
	start_position = position
	
	match initial_direction:
		Direction.LEFT:
			direction = Vector2.LEFT
		Direction.RIGHT:
			direction = Vector2.RIGHT
		Direction.UP:
			direction = Vector2.UP
		Direction.DOWN:
			direction = Vector2.DOWN

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_normal().dot(direction) < 0:
			_flip_direction()
			return

	# Flip if patrol distance exceeded
	var distance = position - start_position
	if direction.x != 0 and abs(distance.x) > patrol_distance:
		_flip_direction()
	elif direction.y != 0 and abs(distance.y) > patrol_distance:
		_flip_direction()

func _flip_direction():
	direction *= -1
	start_position = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.kill_player()
		
func die():
	GameState.play_enemy_hit_sound()
	queue_free()
