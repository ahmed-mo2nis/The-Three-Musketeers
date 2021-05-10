extends Node2D

export var SavedScene: String = ""
var file = File.new()

onready var health = Health
onready var health_bar = $YSort/Player/Musketeer3/HealthBar

func _ready():
	Input.set_mouse_mode(1)
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/Music/Game/lvl1.ogg")
	player.play()

func _input(event):
	if Input.is_key_pressed(KEY_S):
		if file.file_exists("user://sg.txt"):
			var dir = Directory.new()
			#change res to user before exporting
			dir.remove("user://sg.txt")
		file.open("user://sg.txt",File.WRITE)
		file.store_string(SavedScene)
		file.close()

func _on_GlassVase_body_entered(body):
	health.current_health += 1
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/Sounds/Game/334061__garynoden__satisfiedsigh.ogg")
	player.play()


func _on_LevelFinished_body_entered(body):
	if body.name == "Musketeer3":
		get_tree().change_scene("res://Scenes/LevelOneFinished.tscn")
