extends Control

@onready var death_count_label: Label = $DeathCountLabel

func _ready() -> void:
	var total_deaths = GameState.total_deaths
	if total_deaths == 0:
		$DeathCountLabel.text = "You died a total of ... wait, you didn't die?"
	elif total_deaths == 1:
		$DeathCountLabel.text = "You died %d time." % total_deaths
	else:
		$DeathCountLabel.text = "You died %d times." % total_deaths

func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
