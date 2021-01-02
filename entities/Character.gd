extends KinematicBody2D

var bullet = preload("res://gear/Projectile.tscn")

# mechanics
export (int) var faction = 0
export (int) var health = 100

# visual
export var characterName = 'Name'
export (float) var width = 0.7
export (Color) var color = Color('F1C27D')

# movement
export (int) var speed = 50
var path = PoolVector2Array() setget setPath
var target = Vector2()
var velocity = Vector2()
var current_path: Line2D = null

# misc
var progress = 100
var selected = false setget selected_set

func _ready():
	set_process(false)
	target = get_transform().get_origin()
	fire()

func _input(event):
	if event.is_action_pressed('right_click') && selected:
		moveTo(get_global_mouse_position())

func moveTo(value: Vector2):
	var tile = value / 16
	tile = Vector2(int(tile.x), int(tile.y)) + Vector2(0.5, 0.5)
	target = tile * 16
	var newPath = get_node("/root/Game/Navigation").get_simple_path(global_position, target)
	if current_path != null:
		current_path.queue_free()
	current_path = get_node("/root/Game/GameManager").showPath(newPath)
	setPath(newPath)

func fire():
	var bulletInstance = bullet.instance()
	bulletInstance.position = position + Vector2(20,0)
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(200, 0).rotated(rotation))
	get_node("/root/Game/GameManager").add_child(bulletInstance)

func _on_HurtBox_body_entered(body):
	if 'Bullet' in body.name:
		health -= 10
		updateUI()
		body.queue_free()

func _on_ClickBox_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click'):
		selected = !selected
		updateUI()

func updateUI():
	$CharacterUI.updateNameUI()

func setPath(value: PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)

func _process(delta):
	var move_distance = speed * delta
	move_along_path(move_distance)

func move_along_path(distance: float):
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0:
			# move
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			current_path.points = path
			break
		elif path.size() == 1 and distance > distance_to_next:
			# end of path
			position = path[0]
			set_process(false)
			current_path.queue_free()
			break
		distance += distance_to_next
		start_point = path[0]
		
		# look direction
		if path.size() > 0:
			$LayeredSprite.look(get_look_direction(path[1]))
		
		# remove finished path section
		path.remove(0)

func get_look_direction(target: Vector2) -> String:
	var angle = rad2deg((target - position).angle())
	if angle <= -(45) and angle >= -(45+90):
		return 'up'
	elif angle >= -(45+90) and angle >= (45+90):
		return 'left'
	elif angle >= -(45) and angle <= (45):
		return 'right'
	else:# angle >= (45) and angle <= (45+90):
		return 'down'

func look(dir: String):
	$LayeredSprite.look(dir)

func selected_set(value):
	selected = value
	updateUI()