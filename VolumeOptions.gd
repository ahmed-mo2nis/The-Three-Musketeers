extends Control

func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")

func _on_VolumeIndicator_value_changed(value):
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)  
	if value > 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false) 
	var dbValue = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), dbValue)
