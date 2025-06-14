extends Node

@onready var death_player := AudioStreamPlayer.new()
@onready var coin_player := AudioStreamPlayer.new()
@onready var ammo_pickup_player := AudioStreamPlayer.new()
@onready var win_level_player := AudioStreamPlayer.new()
@onready var wall_break_player := AudioStreamPlayer.new()
@onready var wall_hit_player := AudioStreamPlayer.new()
@onready var trigger_wall_disappear_player := AudioStreamPlayer.new()
@onready var enemy_hit_player := AudioStreamPlayer.new()

@onready var music_player := AudioStreamPlayer.new()

var deaths_per_level := {}
var total_deaths := 0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
		
	add_child(death_player)
	death_player.stream = preload("res://sfx/player_death.mp3")
	death_player.volume_db = -15
	death_player.bus = "SFX"
	
	add_child(coin_player)
	coin_player.stream = preload("res://sfx/coin.mp3")
	coin_player.volume_db = -20
	coin_player.bus = "SFX"
	
	add_child(ammo_pickup_player)
	ammo_pickup_player.stream = preload("res://sfx/ammo_pickup.mp3")
	ammo_pickup_player.volume_db = -15
	ammo_pickup_player.bus = "SFX"
	
	add_child(win_level_player)
	win_level_player.stream = preload("res://sfx/win_level.mp3")
	win_level_player.volume_db = -10
	win_level_player.bus = "SFX"
	
	add_child(wall_break_player)
	wall_break_player.stream = preload("res://sfx/wall_break.mp3")
	wall_break_player.volume_db = -15
	wall_break_player.bus = "SFX"
	
	add_child(wall_hit_player)
	wall_hit_player.stream = preload("res://sfx/wall_hit.mp3")
	wall_hit_player.volume_db = -15
	wall_hit_player.bus = "SFX"
	
	add_child(trigger_wall_disappear_player)
	trigger_wall_disappear_player.stream = preload("res://sfx/trigger_wall_disappear.mp3")
	trigger_wall_disappear_player.volume_db = -15
	trigger_wall_disappear_player.bus = "SFX"
	
	add_child(enemy_hit_player)
	enemy_hit_player.stream = preload("res://sfx/enemy_hit.mp3")
	enemy_hit_player.volume_db
	enemy_hit_player.bus = "SFX"
	
	add_child(music_player)
	music_player.stream = preload("res://assets/music/main_theme.mp3")
	music_player.volume_db = -20
	music_player.bus = "Music"

func increase_death_count(level_name: String):
	if not deaths_per_level.has(level_name):
		deaths_per_level[level_name] = 0
	deaths_per_level[level_name] += 1
	total_deaths += 1
	
func reset_death_count():
	deaths_per_level = {}
	total_deaths = 0

func get_death_count(level_name: String) -> int:
	return deaths_per_level.get(level_name, 0)
	
func pause_game():
	get_tree().paused = true
	
func unpause_game():
	get_tree().paused = false
	
func spiel_mir_das_lied_vom_tod():
	death_player.play()
	
func play_coin_collect_sound():
	coin_player.play()
	
func play_ammo_pickup_sound():
	ammo_pickup_player.play()
	
func play_win_level_sound():
	win_level_player.play()
	
func play_wall_break_sound():
	wall_break_player.play()
	
func play_wall_hit_sound():
	wall_hit_player.play()
	
func play_trigger_wall_disappear_sound():
	trigger_wall_disappear_player.play()
	
func play_enemy_hit_sound():
	enemy_hit_player.play()
	
func start_main_theme():
	music_player.play()
