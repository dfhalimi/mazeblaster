extends Control

@onready var pause_settings_screen := get_tree().current_scene.get_node("UI/PauseSettingsScreen")

var paused = false

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("toggle_pause"):
		handle_pause_toggled()
		
func handle_pause_toggled():
	var paused = get_tree().paused
	if paused:
		close()
		GameState.unpause_game()
	else:
		open()
		GameState.pause_game()

func open():
	visible = true

func close():
	visible = false
	pause_settings_screen.close()

func _on_resume_button_pressed() -> void:
	close()
	GameState.unpause_game()

func _on_settings_button_pressed() -> void:
	visible = false
	pause_settings_screen.open()

func _on_back_to_main_menu_button_pressed() -> void:
	GameState.reset_death_count()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
