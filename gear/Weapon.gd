extends Node2D

var bullet = preload("res://gear/Projectile.tscn")

# weapon stats
export (int) var accuracy = 90
export (int) var knock_back = 1
export (int) var range_distance = 200 setget set_range
export (int) var charge_time = 1
export (int) var fire_rate = 10
export (int) var burst_size = 3
export (int) var projectile_speed = 200

# scan values
var bodies_in_range = []

# idle visuals
var idle_rotation = 45
var idle_position = Vector2(6,-5)

# combat
var current_target_location: Vector2
var active_burst_size = 0 setget set_active_burst_size

func _ready():
	position = -$"Sprite/Handle".position
	# take_idle_position()

func take_idle_position():
	rotate(deg2rad(idle_rotation))
	position -= idle_position

func _input(event: InputEvent):
	if event.is_action_pressed('click') and get_parent().selected:
		shoot_at(get_global_mouse_position())

func shoot_at(target: Vector2):
	# transform
	look_at(target)
	position = -$"Sprite/Handle".position.rotated(rotation)
	var angle = fmod(abs(rotation_degrees), 360)
	$Sprite.flip_v = angle > 90 and angle < 270
	
	# initialize
	var bulletInstance = bullet.instance()
	bulletInstance.position = $"Sprite/Muzzle".global_position
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	
	# mechanics
	bulletInstance.max_distance = range_distance
	
	# fire bullet
	get_node("/root/Game/GameManager/Projectiles").add_child(bulletInstance)


func set_range(value: int):
	range_distance = value
	
	# todo resize RangeArea/CollisionShape/Circleshape radius
	
	# todo call this funcion when a different weapon is equipped by the character 
	# or his range related stats change
	
	print('set range called')

func _on_RangeArea_body_entered(body):
	if 'Character' in body.name:
		bodies_in_range.append(body)

func _on_RangeArea_body_exited(body):
	bodies_in_range.erase(body)

func fire(target: Vector2):
	current_target_location = target
	if $Cooldown.is_stopped():
		take_aim()

func take_aim():
	$AimTime.start(charge_time)

func _on_Cooldown_timeout():
	take_aim()

func _on_AimTime_timeout():
	set_active_burst_size(burst_size)

func _on_BurstTimer_timeout():
	# todo amount of spread, etc.
	shoot_at(current_target_location)

func set_active_burst_size(value):
	active_burst_size = value
	# todo start contnuous burst timer
	# stop when active burst timer reaches 0
