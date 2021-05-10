extends Control

onready var timer = get_node("Timer")

func _ready():
	Input.set_mouse_mode(1)
	timer.set_wait_time(3)
	timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/CutSceneLevelThreeB.tscn")
