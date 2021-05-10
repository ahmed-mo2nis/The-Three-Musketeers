extends Node2D

export var SavedScene: String = ""
var file = File.new()

onready var health = Health
onready var health_bar = $YSort/Player/Musketeer3/HealthBar

onready var transition_cam : Camera2D = $YSort/Player/TransitionCamera
onready var cam_tween : Tween = $YSort/Player/CameraTween

onready var p1 : Musketeer = $YSort/Player/Musketeer1	#Porthos
onready var p2 : Musketeer = $YSort/Player/Musketeer2	#Athos
onready var p3 : Musketeer = $YSort/Player/Musketeer3	#D'artangan
onready var p4 : Musketeer = $YSort/Player/Musketeer4	#Aramis

onready var players = [p1, p2, p3, p4]

onready var active_player : Musketeer = players[0]

func _ready():
	Input.set_mouse_mode(1)
	switch_player(p1)
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/Music/Game/lvl3.ogg")
	player.play()

func _input(event):
	if event.is_action_pressed("ui_switch_player"):
		match event.scancode:
			KEY_1: switch_player(players[0])
			KEY_2: switch_player(players[1])
			KEY_3: switch_player(players[2])
			KEY_4: switch_player(players[3])
	if Input.is_key_pressed(KEY_S):
		if file.file_exists("user://sg.txt"):
			var dir = Directory.new()
			#change res to user before exporting
			dir.remove("user://sg.txt")
		file.open("user://sg.txt",File.WRITE)
		file.store_string(SavedScene)
		file.close()
			
func _process(delta):
	if Input.is_action_pressed("ui_left"): active_player.MovementLoop(delta)
	if Input.is_action_pressed("ui_right"): active_player.MovementLoop(delta)
	if Input.is_action_pressed("ui_up"): active_player.MovementLoop(delta)
	if Input.is_action_pressed("ui_down"): active_player.MovementLoop(delta)

func switch_player (new_player : Musketeer):
	transition_cam.global_position = active_player.global_position
	transition_cam.current = true
	cam_tween.interpolate_property(transition_cam, "global_position", null, new_player.global_position, 0.2)
	cam_tween.start()
	yield(cam_tween,"tween_completed")
	active_player = new_player
	active_player.camera.current = true
	
func _on_GlassVase_body_entered(body):
	health.current_health += 1
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/Sounds/Game/334061__garynoden__satisfiedsigh.ogg")
	player.play()

func _on_LevelFinished_body_entered(body):
	if body.name == "Musketeer1":
		get_tree().change_scene("res://Scenes/LevelThreeFinished.tscn")
	elif body.name == "Musketeer2":
		get_tree().change_scene("res://Scenes/LevelThreeFinished.tscn")
	elif body.name == "Musketeer3":
		get_tree().change_scene("res://Scenes/LevelThreeFinished.tscn")
	elif body.name == "Musketeer4":
		get_tree().change_scene("res://Scenes/LevelThreeFinished.tscn")
