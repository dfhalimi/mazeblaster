extends Node2D

var coins_collected := 0
var total_coins := 0
@onready var coin_label := $UI/CoinsLabel

func _ready():
	var coins = get_tree().get_nodes_in_group("coins")
	total_coins = coins.size()
	for coin in coins:
		coin.coin_collected.connect(_on_coin_collected)

func _on_coin_collected():
	coins_collected += 1
	coin_label.text = "Coins: %d" % coins_collected

	if coins_collected == total_coins:
		show_win_message()
		
func show_win_message():
	var label = Label.new()
	label.text = "You Win!"
	label.position = Vector2(500, 300)
	label.add_theme_font_size_override("font_size", 48)
	add_child(label)
	
func kill_player():
	get_tree().reload_current_scene()
