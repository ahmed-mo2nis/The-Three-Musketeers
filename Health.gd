extends Node

signal max_changed(new_max)
signal health_changed(new_health)
signal killed

export (int) var max_health = 10 setget set_max
onready var current_health = max_health setget set_current

func set_max(new_max):
	max_health = new_max
	max_health = max(1, new_max)
	emit_signal("max_changed", max_health)

func set_current(new_value):
	current_health = new_value
	current_health = clamp(current_health, 0, max_health)
	emit_signal("health_changed", current_health)
	
	if current_health == 0:
		emit_signal("killed")

func initialize():
	emit_signal("max_changed", max_health)
	emit_signal("health_changed", current_health)
