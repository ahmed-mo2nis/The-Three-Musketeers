extends Area2D

func _on_GlassVase_body_entered(body):
	if body.name == "Musketeer1":
		queue_free()
	elif body.name == "Musketeer2":
		queue_free()
	elif body.name == "Musketeer3":
		queue_free()
	elif body.name == "Musketeer4":
		queue_free()
