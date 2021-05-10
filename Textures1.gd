extends Control

func _ready():
	Input.set_mouse_mode(1)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene("res://Scenes/Credits.tscn")
