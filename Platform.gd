extends RigidBody2D

var speed = 100
var gravity = 120
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += gravity * delta
	add_central_force(velocity)
