#tool
extends Area2D

export(int) var speed = -20
export(int) var max_speed = 5
export(int) var max_height = 3000
var elapsed_time = 0


func _process(delta):

	elapsed_time += delta
	var time_factor = min(floor(elapsed_time/3), max_speed)
	var margin = $TextureRect.margin_top
	
	if abs(margin) > max_height:
		return
		
	$TextureRect.margin_top += time_factor * (speed * delta)

	
	var tex = $TextureRect.get_texture()
	var col = $CollisionShape2D.get_shape()
	var target = $TextureRect.margin_top
	col.set_extents(Vector2(2000, target))
	#$Label.text = str(time_factor)
