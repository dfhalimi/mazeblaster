extends Control

@onready var master_slider: HSlider = $MasterSlider
@onready var sfx_slider: HSlider = $SFXSlider
@onready var music_slider: HSlider = $MusicSlider

var main_menu: Node = null

func _ready() -> void:
	main_menu = get_parent()
	visible = false
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_back_button_pressed() -> void:
	main_menu.open()
	close()
	
func open():
	visible = true
	
func close():
	visible = false
	
func db_to_linear(db: float) -> float:
	return 0.0 if db <= -80.0 else pow(10, db / 20.0)
	
func linear_to_db(value: float) -> float:
	return -80 if value <= 0.0 else 20.0 * log(value) / log(10)
