extends Node

var state = 0

func _ready():
	$Player.honor = $Player.max_honor
	$CanvasLayer/DeathScreen/VBoxContainer/GameOverText.set_visible(false)
	$CanvasLayer/DeathScreen/VBoxContainer/GameOverInstructions.set_visible(false)
	$CanvasLayer/GUI/HBoxContainer/Counters/LifeCounter/NinePatchRect/HBoxContainer/Label.text = "x " + str(GLOBALS.lives)
	$CanvasLayer/LevelStart.set_visible(true)
	yield(get_tree().create_timer(2), "timeout")
	$CanvasLayer/LevelStart.set_visible(false)
	
func _input(event):
	if state == 0:
		return
	if event.is_action_pressed("jump"):
		if GLOBALS.lives <= 0:
			get_tree().change_scene("res://GameOver.tscn")
		else:
			get_tree().reload_current_scene()
		return

func _on_Player_honor_changed(val):
	$CanvasLayer/GUI/HBoxContainer/Bars/Bar/ProgressBar.set_value(val)

func _on_Player_death():
	GLOBALS.lives -= 1

	$CanvasLayer/GUI/HBoxContainer/Counters/LifeCounter/NinePatchRect/HBoxContainer/Label.text = "x " + str(GLOBALS.lives)
	$CanvasLayer/DeathScreen/VBoxContainer/GameOverText.set_visible(true)
	yield(get_tree().create_timer(2), "timeout")
	$CanvasLayer/DeathScreen/VBoxContainer/GameOverInstructions.set_visible(true)
	
	state = 1


func _on_Exit_body_entered(body):
	# next level
	if body.name == "Player":
		var next = $Exit.next_level
		get_tree().change_scene(next)
