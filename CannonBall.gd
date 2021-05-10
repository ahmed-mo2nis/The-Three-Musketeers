extends Node2D

var direction = 0
var ball_speed = 10

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/Sounds/Game/528493__diicorp95__cannon-explosion.ogg")
	player.play()

func _process(delta):
	var move_direction = Vector2(1,0).rotated(direction)
	global_position += (move_direction * ball_speed)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
