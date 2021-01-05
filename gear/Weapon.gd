extends Node2D

var bullet = preload("res://gear/Projectile.tscn")

signal salvo_fired

# weapon stats											# implemented
export (int) var accuracy = 50							# x
export (int) var stopping_power = 1						# o
export (int) var range_distance = 500 setget set_range	# x
export (int) var charge_time = 1						# x
export (int) var fire_rate = 10							# x
export (int) var burst_size = 3							# x
export (int) var projectile_speed = 200					# x

# scan values
var bodies_in_range = []

# idle visuals
var idle_rotation = 45
var idle_position = Vector2(6,-5)

# combat
var current_target_location: Vector2
var active_burst_size = 0 setget set_active_burst_size
var accuracy_impactfulness = 100

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
	bulletInstance.max_distance = range_distance / 2.5 # why is 2.5 the correct value for 500 range here?
	
	# fire bullet
	get_node("/root/Game/GameManager/Projectiles").add_child(bulletInstance)


func set_range(value: int):
	print('updating range')
	range_distance = value
	$'RangeArea/CollisionShape2D'.shape.radius = range_distance
	print('set range called')

func _on_RangeArea_body_entered(body):
	if 'Character' in body.name:
		bodies_in_range.append(body)

func _on_RangeArea_body_exited(body):
	bodies_in_range.erase(body)

func fire(target: Vector2):
	current_target_location = target
	if $AimTimer.is_stopped() and $BurstTimer.is_stopped() and active_burst_size <= 0:
		take_aim()

func take_aim():
	$AimTimer.start(charge_time)

func _on_AimTime_timeout():
	set_active_burst_size(burst_size)

func _on_BurstTimer_timeout():
	if active_burst_size > 0:
		var dx = 1
		var dy = 1
		if randi() % 2:
			dx = -1 
		if randi() % 2:
			dy = -1 
		var deviation = (100 - accuracy) * (randi() % accuracy_impactfulness) / 100
		var deviation_vector = Vector2(deviation*dx, deviation*dy)
		print(deviation_vector)
		var shooting_at = current_target_location + deviation_vector # todo amount of spread
		shoot_at(shooting_at)
		active_burst_size -= 1
		$BurstTimer.start(1.0 / fire_rate)
	else:
		$BurstTimer.stop()
		emit_signal('salvo_fired')

func set_active_burst_size(value):
	active_burst_size = value
	$BurstTimer.start(1.0 / fire_rate)
