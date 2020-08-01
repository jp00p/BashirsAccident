extends Node2D

func _ready():
	GLOBALS.lives = GLOBALS.max_lives

func _on_Button_pressed():
	$AnimationPlayer.play("engage")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Intro.tscn")
