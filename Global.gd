extends Node

onready var settings = load("res://Scenes/Keys.tscn")
var file_path = "res://keys.ini"	#change res when exporting to user ????
var config_file
var key_binds = {}

func _input(event):
	if Input.is_action_just_pressed("Click"):
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://Audio/Sounds/Game/click.ogg")
		player.play()

func _ready():
	config_file = ConfigFile.new()
	if config_file.load(file_path) == OK:
		for key in config_file.get_section_keys("keys"):
			var key_value = config_file.get_value("keys", key)
			
			if str(key_value) !="":
				key_binds[key] = key_value
			else:
				key_binds[key] = null
	else:
		print("CONFIG FILE NOT FOUND")
#		get_tree().quit()
		
	set_game_binds()
		
func set_game_binds():
	for key in key_binds.keys():
		var value = key_binds[key]
		
		var action_list = InputMap.get_action_list(key)
		if !action_list.empty():
			InputMap.action_erase_event(key, action_list[0])
			
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)
		
func write_config():
	for key in key_binds.keys():
		var key_value = key_binds[key]
		if key_value != null:
			config_file.set_value("keys", key, key_value)
		else:
			config_file.set_value("keys", key, "")
	config_file.save(file_path)
