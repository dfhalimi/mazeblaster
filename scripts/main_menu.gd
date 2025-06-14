extends Control

@onready var settings_screen: Control = $SettingsScreen
@onready var title_label: Label = $TitleLabel
@onready var start_button: Button = $StartButton
@onready var settings_button: Button = $SettingsButton
@onready var quit_button: Button = $QuitButton

func _on_start_button_pressed() -> void:
	GameState.start_main_theme()
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
	
func _on_settings_button_pressed() -> void:
	close()
	settings_screen.open()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func open():
	title_label.visible = true
	start_button.visible = true
	settings_button.visible = true
	#quit_button.visible = true
	
func close():
	title_label.visible = false
	start_button.visible = false
	settings_button.visible = false
	#quit_button.visible = false
