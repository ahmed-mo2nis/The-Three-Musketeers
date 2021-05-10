extends Control

onready var timer = get_node("Timer")

func _ready():
	Input.set_mouse_mode(1)
	timer.set_wait_time(14.23)
	timer.start()
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene("res://Scenes/StartMenu.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")
