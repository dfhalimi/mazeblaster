extends CharacterBody2D

@export var speed := 300.0
@export var bullet_scene: PackedScene
@export var bullet_speed := 400.0
@export var ammo := 1

@onready var ammo_label := get_tree().current_scene.get_node("UI/AmmoLabel")

var last_move_dir := Vector2.RIGHT

func _ready():
	update_ammo_ui()

func _physics_process(delta):
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if dir != Vector2.ZERO:
		last_move_dir = dir.normalized()

	velocity = dir.normalized() * speed
	move_and_slide()

	
func _input(event):
	if event.is_action_pressed("shoot") and ammo > 0:
		shoot_bullet()
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()
		
func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	var mouse_pos = get_global_mouse_position()
	var aim_dir = (mouse_pos - position).normalized()

	bullet.position = position + aim_dir * 16
	bullet.direction = aim_dir

	get_parent().add_child(bullet)
	ammo -= 1
	update_ammo_ui()
	
func update_ammo_ui():
	ammo_label.text = "Ammo: %d" % ammo
