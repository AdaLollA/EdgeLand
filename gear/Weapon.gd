extends Node2D

export (int) var accuracy = 90
export (int) var knock_back = 1
export (int) var range_distance = 100
export (int) var charge_time = 1
export (int) var fire_rate = 10
export (int) var burst_size = 3

var idle_rotation = 45
var idle_position = Vector2(6,-5)

func _ready():
	position -= $Handle.position
	take_idle_position()

func take_idle_position():
	rotate(deg2rad(idle_rotation))
	position -= idle_position
