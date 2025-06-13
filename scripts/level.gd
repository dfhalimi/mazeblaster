extends Node2D

@onready var coin_label := $UI/CoinsLabel
@onready var level_label := $UI/LevelLabel
@onready var death_label := $UI/DeathLabel

@export var next_level: PackedScene

var coins_collected := 0
var total_coins := 0

func _ready():
	var coins = get_tree().get_nodes_in_group("coins")
	total_coins = coins.size()
	for coin in coins:
		coin.coin_collected.connect(_on_coin_collected)
	update_level_label()
	update_death_label()

func _on_coin_collected():
	GameState.play_coin_collect_sound()
	
	coins_collected += 1
	coin_label.text = "Coins: %d" % coins_collected

	if coins_collected == total_coins:
		GameState.play_win_level_sound()
		show_win_message()
		
func show_win_message():
	if next_level:
		get_tree().change_scene_to_packed(next_level)
	else:
		get_tree().change_scene_to_file("res://scenes/ui/win_screen.tscn")
	
func update_level_label():
	var scene_path = get_tree().current_scene.scene_file_path
	var scene_name = scene_path.get_file().get_basename() # e.g., "level_02"

	var parts = scene_name.split("_")
	if parts.size() == 2 and parts[0].to_lower() == "level":
		var level_number = parts[1]
		var label = level_label
		label.text = "Level: " + str(int(level_number))
		
func update_death_label():
	var level_name = get_name()
	var deaths = GameState.get_death_count(level_name)
	death_label.text = "Deaths: %d" % deaths
