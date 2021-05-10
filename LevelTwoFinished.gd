extends Control

onready var timer = get_node("Timer")

func _ready():
	Input.set_mouse_mode(1)
	timer.set_wait_time(8)
	timer.start()
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/Music/Game/LevelFinished.ogg")
	player.play()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/CutSceneLevelThreeA.tscn")
