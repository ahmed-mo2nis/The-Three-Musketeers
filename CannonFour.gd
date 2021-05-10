extends Node2D

var ball : PackedScene
onready var player = get_tree().get_root().get_node("LevelFour/YSort/Player/Musketeer3")

func _ready():
	ball = ResourceLoader.load("res://Scenes/CannonBall.tscn")

func _process(delta):
	var distance = global_position.distance_to(player.global_position)
	look_at(player.global_position)

func _on_Timer_timeout():
	var cannon_ball = ball.instance()
	cannon_ball.direction = rotation
	cannon_ball.rotation = rotation
	cannon_ball.global_position = global_position
	get_parent().add_child(cannon_ball)
