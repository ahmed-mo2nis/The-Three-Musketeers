extends KinematicBody2D

class_name Musketeer

onready var camera : Camera2D = $PlayerCam
onready var health = Health
onready var health_bar = $HealthBar

var speed = 0
var max_speed = 400
var acceleration = 1200
var move_direction = Vector2()
var moving = false
var attacking = false
var stabing = false
var attack_direction
var stab_direction

var anim_direction = "S"
var anim_mode = "Idle"
var animation

func _ready():
	health.connect("health_changed", health_bar, "set_value")
	health.connect("max_changed", health_bar, "set_max")
	health.initialize()
	$"PlayerCam/UI/ExitPlayConfirm".hide()
	$"PlayerCam/UI/PausePlayConfirm".hide()
	$"PlayerCam/UI/RestartPlayConfirm".hide()
	$"PlayerCam/UI/SavePlayConfirm".hide()

func _physics_process(delta):
	if Input.is_action_pressed("Attack"):
		moving = false
		stabing = false
		attacking = true
		attack_direction = move_direction
		Attack()
	if Input.is_action_pressed("Stab"):
		moving = false
		stabing = true
		attacking = false
		stab_direction = move_direction
		Stab()
	MovementLoop(delta)
	if Input.is_key_pressed(KEY_E):
		$"PlayerCam/UI/ExitPlayConfirm".show()
	if Input.is_key_pressed(KEY_Y):
		health.current_health = 10
		get_tree().change_scene("res://Scenes/StartMenu.tscn")
	if Input.is_key_pressed(KEY_N):
		$"PlayerCam/UI/ExitPlayConfirm".hide()
	if Input.is_key_pressed(KEY_P):
		get_tree().paused = true
		$"PlayerCam/UI/PausePlayConfirm".show()
	if Input.is_key_pressed(KEY_C):
		get_tree().paused = false
		$"PlayerCam/UI/PausePlayConfirm".hide()
	if Input.is_key_pressed(KEY_R):
		$"PlayerCam/UI/RestartPlayConfirm".show()
	if Input.is_key_pressed(KEY_F):
		health.current_health = 10
		get_tree().change_scene("res://Scenes/LevelOne.tscn")
	if Input.is_key_pressed(KEY_K):
		$"PlayerCam/UI/RestartPlayConfirm".hide()
	if Input.is_key_pressed(KEY_S):
		$"PlayerCam/UI/SavePlayConfirm".show()
		
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			$"PlayerCam/UI/SavePlayConfirm".hide()
	
func _process(delta):
	AnimationLoop()

func MovementLoop(delta):
	move_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
	if move_direction == Vector2(0,0):
		moving = false
		speed = 0
	else:
		moving = true
		stabing = false
		attacking = false
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
		var motion = move_direction.normalized() * speed
		move_and_slide(motion)
		
func Attack():
	yield(get_node("AnimationPlayer"), "animation_finished" )
	attacking = false
	anim_mode = "Idle"
	
func Stab():
	yield(get_node("AnimationPlayer"), "animation_finished" )
	stabing = false
	anim_mode = "Idle"

func AnimationLoop():
	if moving:
		match move_direction:
			Vector2(-1,0):
				anim_direction = "W"
			Vector2(1,0):
				anim_direction = "E"
			Vector2(0,0.5):
				anim_direction = "S"
			Vector2(0,-0.5):
				anim_direction = "N"
			Vector2(-1,-0.5):
				anim_direction = "NW"
			Vector2(-1,0.5):
				anim_direction = "SW"
			Vector2(1,-0.5):
				anim_direction = "NE"
			Vector2(1,0.5):
				anim_direction = "SE"
	
	if moving == true:
		if move_direction != Vector2(0,0):
			anim_mode = "Walk"
	elif attacking:
		anim_mode = "Fence"
	elif stabing:
		anim_mode = "Stab"
	else:
		anim_mode = "Idle"
	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)

func _on_SwordBlade_area_entered(area):
	if area.name=="EnemyBody":
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://Audio/Sounds/Game/1432__lostchocolatelab__01sword04.ogg")
		player.play()

func _on_MusketeerBody_area_entered(area):
	if area.name=="EnemySwordBlade":
		health.current_health -= 1
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://Audio/Sounds/Game/553285__nettoi__hurt4.ogg")
		player.play()
		
	if area.name=="CannonBallArea":
		health.current_health -= 2
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://Audio/Sounds/Game/553285__nettoi__hurt4.ogg")
		player.play()
		
	if area.name=="EnemyClub":
		health.current_health -= 3
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://Audio/Sounds/Game/553285__nettoi__hurt4.ogg")
		player.play()
		
	if health.current_health == 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		health.current_health = 10
