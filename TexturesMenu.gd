extends Control

func _ready():
	Input.set_mouse_mode(0)

func _on_TexturesOneButton_pressed():
	get_tree().change_scene("res://Scenes/Textures.tscn")

func _on_TexturesTwoButton_pressed():
	get_tree().change_scene("res://Scenes/Textures1.tscn")

func _on_TexturesThreeButton_pressed():
	get_tree().change_scene("res://Scenes/Textures2.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")
