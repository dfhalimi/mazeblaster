extends CharacterBody2D

@export var speed := 300.0
@export var bullet_scene: PackedScene
@export var bullet_speed := 400.0
@export var ammo := 1

@onready var ammo_label := get_tree().current_scene.get_node("UI/AmmoLabel")
@onready var aim_line: Line2D = $AimLine
@onready var raycast := RayCast2D.new()
@onready var shoot_sound: AudioStreamPlayer2D = $ShootSound
@onready var empty_clip_sound: AudioStreamPlayer2D = $EmptyClipSound

var aim_direction := Vector2.RIGHT
var max_line_length := 200.0

# For detecting mouse idle
var last_mouse_position := Vector2.ZERO
var mouse_idle_time := 0.0
const MOUSE_IDLE_THRESHOLD := 1.0  # seconds

func _ready():
	update_ammo_ui()
	add_child(raycast)
	raycast.enabled = false
	raycast.collision_mask = 0xFFFFFFFF  # Includes all layers
	
func _process(delta):
	update_aim_direction()
	update_aim_line()

func _physics_process(delta):
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	velocity = dir.normalized() * speed
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("shoot"):
		shoot_bullet()
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()
		
func shoot_bullet():
	if ammo > 0:
		var bullet = bullet_scene.instantiate()
		var aim_dir = aim_direction.normalized()
		
		$ShootSound.play()

		bullet.position = position + aim_dir * 16
		bullet.direction = aim_dir
		bullet.rotation = aim_dir.angle()

		get_parent().add_child(bullet)
		ammo -= 1
		update_ammo_ui()
	else:
		$EmptyClipSound.play()
	
func update_ammo_ui():
	ammo_label.text = "Ammo: %d" % ammo
	
func kill_player():
	GameState.spiel_mir_das_lied_vom_tod()
	
	var level_name = get_tree().current_scene.name
	GameState.increase_death_count(level_name)
	get_tree().reload_current_scene()
	
func update_aim_direction():
	aim_direction = (get_global_mouse_position() - global_position).normalized()

func update_aim_line():
	var end_point = global_position + aim_direction * max_line_length

	raycast.global_position = global_position
	raycast.target_position = aim_direction * max_line_length
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("walls") or collider.is_in_group("destructible") or collider.is_in_group("enemies"):
			end_point = raycast.get_collision_point()

	var local_end = to_local(end_point)

	# Draw the line
	aim_line.clear_points()

	aim_line.add_point(Vector2.ZERO)
	aim_line.add_point(local_end)
