extends Control

var file = File.new()

func _ready():
	Input.set_mouse_mode(0)
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/CutSceneLevelOneA.tscn")

func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://Scenes/HowToPlay.tscn")
	
func _on_LoadButton_pressed():
	if file.file_exists("user://sg.txt") == false:
		#change res to user before exporting
		$CenterContainer/VBoxContainer/ConfirmationDialog.visible = true
	else:
		file.open("user://sg.txt", File.READ)
		var content = file.get_as_text()
		get_tree().change_scene(content)
		file.close()
		return content

func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_ExitButton_pressed():
	get_tree().change_scene("res://Scenes/ExitGameConfirm.tscn")
