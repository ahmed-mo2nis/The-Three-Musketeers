extends Control
	
func _on_VolumeButton_pressed():
	get_tree().change_scene("res://Scenes/VolumeOptions.tscn")

func _on_RemappingButton_pressed():
	get_tree().change_scene("res://Scenes/Keys.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")
