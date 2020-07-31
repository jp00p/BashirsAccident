extends Node2D

var speed = -5
var acceleration_x = 0.05
var acceleration_y = 0.05

func _ready():
	$AnimationPlayer.play("intro")
	
func _input(event):
	if event.is_action_pressed("jump") and !$AnimationPlayer.is_playing():
		get_tree().change_scene("res://levels/Level1.tscn")

func _process(delta):
	var offset_x = $ParallaxBackground/ParallaxLayer.motion_offset.x
	offset_x = lerp(offset_x, offset_x+speed, acceleration_x)
	var offset_y = $ParallaxBackground/ParallaxLayer.motion_offset.y
	offset_y = lerp(offset_y, offset_y+speed, acceleration_y)
	$ParallaxBackground/ParallaxLayer.motion_offset.x = offset_x
	$ParallaxBackground/ParallaxLayer.motion_offset.y = offset_y
