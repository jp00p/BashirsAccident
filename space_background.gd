extends ParallaxBackground

var speed = -5
var acceleration_x = 0.05
var acceleration_y = 0.05

func _process(delta):
	var offset_x = $ParallaxLayer.motion_offset.x
	offset_x = lerp(offset_x, offset_x+speed, acceleration_x)
	var offset_y = $ParallaxLayer.motion_offset.y
	offset_y = lerp(offset_y, offset_y+speed, acceleration_y)
	$ParallaxLayer.motion_offset.x = offset_x
	$ParallaxLayer.motion_offset.y = offset_y
