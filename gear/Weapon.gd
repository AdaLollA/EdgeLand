extends Node2D

var bullet = preload("res://gear/Projectile.tscn")

export (int) var accuracy = 90
export (int) var knock_back = 1
export (int) var range_distance = 100
export (int) var charge_time = 1
export (int) var fire_rate = 10
export (int) var burst_size = 3
export (int) var projectile_speed = 200

var idle_rotation = 45
var idle_position = Vector2(6,-5)

func _ready():
	position -= $Handle.position
	# take_idle_position()

func take_idle_position():
	rotate(deg2rad(idle_rotation))
	position -= idle_position

func _input(event: InputEvent):
	if event.is_action_pressed('click') and get_parent().selected:
		shoot_at(event.position)

func shoot_at(target: Vector2):
	print(target)
	var bulletInstance = bullet.instance()
	bulletInstance.position = $Muzzle.global_position
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	get_node("/root/Game/GameManager/Projectiles").add_child(bulletInstance)
