extends KinematicBody2D

signal honor_changed
signal death

export (int) var speed = 250
export (int) var jump_speed = -600
export (int) var gravity = 1200

export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2()
var min_jump = -200
var flip_sprite = false
var in_piss = false
var max_honor = 1000
var honor = max_honor setget _change_honor
var dead = false

func _ready():
	honor = max_honor
	emit_signal("honor_changed", honor)

func _change_honor(val):
	honor = clamp(val, 0, max_honor)
	if honor < max_honor:
		emit_signal("honor_changed", honor)
	if honor <= 0:
		dead = true
		$Sprite/AnimationPlayer.stop()
		emit_signal("death")	

func get_input():
	if honor <= 0:
		return
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += 1
		flip_sprite = true
	if Input.is_action_pressed("walk_left"):
		dir -= 1
		flip_sprite = false
	if dir != 0:
		$Sprite/AnimationPlayer.play("walking")
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		$Sprite/AnimationPlayer.stop()
		velocity.x = lerp(velocity.x, 0, friction)
	


func _input(event):
	if honor <= 0:
		return
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	if event.is_action_released("jump"):
		velocity.y = clamp(velocity.y, min_jump, velocity.y)
	if Input.is_action_just_pressed("down"):
		if is_on_floor():
			self.position = Vector2(self.position.x, self.position.y + 1)
	
func _physics_process(delta):
	
	get_input() #handle controls
	$Sprite.flip_h = flip_sprite #flip sprite
	velocity.y += gravity * delta #apply gravity
	
	if in_piss and not dead:
		self.honor = self.honor - 1 #tick down honor
		$Sprite.get_material().set_shader_param("line_color", Color(0.8, 0.8, 0))
	elif not dead:
		self.honor += 0.5 #regain honor
		$Sprite.get_material().set_shader_param("line_color", Color(1, 1, 1, 0))
	if dead and in_piss:
		$Sprite.rotation_degrees = 180 #dead
		gravity = -5 #float

	velocity = move_and_slide(velocity, Vector2.UP)	



func _on_Deadzone_body_entered(body):
	if body.name == "Player":
		gravity = 1300
		speed = 200
		friction = 0.05
		jump_speed = -700
		in_piss = true
		if dead:
			gravity = -5
		

func _on_Deadzone_body_exited(body):
	if body.name == "Player":
		gravity = 1200
		speed = 250
		friction = 0.5
		jump_speed = -600
		in_piss = false
		if dead:
			gravity = 1200
