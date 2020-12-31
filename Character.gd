extends Node2D

var speed = 150

func _process(delta):
	move_local_x(speed*delta)
