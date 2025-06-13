extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
	
func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings_screen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
