extends Node2D

var scales = [-0.9, -0.95, 1, 1.05, 1.10]

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene("res://Title.tscn")


func _on_Timer_timeout():
	var choice = scales[randi() % scales.size()]
	$AudioStreamPlayer.set_pitch_scale(choice)
