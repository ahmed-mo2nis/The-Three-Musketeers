extends KinematicBody2D

onready var path_follow = get_parent()

var speed = 150
var move_direction = 0

var max_hp = 5
var current_hp

var player_position

var anim_direction
var anim_mode = "Walk"
var animation

var player_in_range

var sword_direction

var state

func _ready():
	current_hp = max_hp
	state = "Patrol"

func _process(delta):
	match state:
		"Idle":
			pass
		"Patrol":
			Patrol(delta)
		"Attack":
			Attack()
		"Death":
			death()
			
func Patrol(delta):
	MovementLoop(delta)
	AnimationLoop()

func MovementLoop(delta):
	var previous_position = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + speed * delta)
	var position = path_follow.get_global_position()
	move_direction = (position.angle_to_point(previous_position) / 3.14) * 180

func AnimationLoop():
	if move_direction <= 15 and move_direction >= -15:
		anim_direction = "E"
	elif move_direction <= 60 and move_direction >= 15:
		anim_direction = "SE"
	elif move_direction <= 120 and move_direction >= 60:
		anim_direction = "S"
	elif move_direction <= 165 and move_direction >= 120:
		anim_direction = "SW"
	elif move_direction >= -60 and move_direction <= -15:
		anim_direction = "NE"
	elif move_direction >= -120 and move_direction <= -60:
		anim_direction = "N"
	elif move_direction >= -165 and move_direction <= -120:
		anim_direction = "NW"
	elif move_direction <= -165 and move_direction >= 165:
		anim_direction = "W"

	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)
			
func Attack():
	get_node("AnimationPlayer").play("Stab_S")	
			
func death():
	get_node("Sprite/EnemyBody/CollisionShape2D").set_deferred("disabled", true)
	get_node("AnimationPlayer").play("Death_S")
	yield(get_node("AnimationPlayer"), "animation_finished" )
	$".".hide()

func _on_LOS_body_entered(body):
	if body.name == "Musketeer1":
		player_in_range = true
		state = "Attack"
	elif body.name == "Musketeer2":
		player_in_range = true
		state = "Attack"
	elif body.name == "Musketeer3":
		player_in_range = true
		state = "Attack"
	elif body.name == "Musketeer4":
		player_in_range = true
		state = "Attack"

func _on_LOS_body_exited(body):
	if body.name == "Musketeer1":
		player_in_range = false
	elif body.name == "Musketeer2":
		player_in_range = false
	elif body.name == "Musketeer3":
		player_in_range = false
	elif body.name == "Musketeer4":
		player_in_range = false
		
func _on_EnemyBody_area_entered(area):
	if area.name=="SwordBlade":
		current_hp -= 1
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://Audio/Sounds/Game/413176__micahlg__male-hurt1.ogg")
		player.play()
		if current_hp <= 0:
			state = "Death"
