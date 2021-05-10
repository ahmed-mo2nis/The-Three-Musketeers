extends Control

onready var button_container = get_node("CenterContainer/VBoxContainer")
onready var button_script = load("res://Scripts/KeyButton.gd")

var key_binds
var buttons = {}

func _ready():
	$Panel.hide()
	key_binds = Global.key_binds.duplicate()
	for key in key_binds.keys():
		var hbox = HBoxContainer.new()
		var label = Label.new()
		var button = Button.new()
		
		hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		label.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		
		label.text = key
		
		var button_value = key_binds[key]
		
		if button_value != null:
			button.text = OS.get_scancode_string(button_value)
		else:
			button.text = "Unassigned"
		
		button.set_script(button_script)
		button.key = key
		button.value = button_value
		button.menu = self
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		
		hbox.add_child(label)
		hbox.add_child(button)
		button_container.add_child(hbox)
		
		buttons[key] = button

func change_bind(key, value):
	key_binds[key] = value
	for k in key_binds.keys():
		if k != key and value != null and key_binds[k] == value:
			key_binds[k] = null
			buttons[k].value = null
			buttons[k].text = "Unassigned"

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_SaveButton_pressed():
	Global.key_binds = key_binds.duplicate()
	Global.set_game_binds()
	Global.write_config()
	$Panel.show()
