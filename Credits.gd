extends Control

func _ready():
	Input.set_mouse_mode(0)

func _on_DeveloperButton_pressed():
	get_tree().change_scene("res://Scenes/Developer.tscn")

func _on_SoftwareButton_pressed():
	get_tree().change_scene("res://Scenes/Software.tscn")

func _on_TexturesButton_pressed():
	get_tree().change_scene("res://Scenes/TexturesMenu.tscn")

func _on_SoundButton_pressed():
	get_tree().change_scene("res://Scenes/Sounds.tscn")

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")
