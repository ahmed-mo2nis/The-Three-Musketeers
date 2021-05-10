extends Control

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
