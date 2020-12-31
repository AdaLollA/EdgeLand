extends KinematicBody2D

export var characterName = 'Name'
export (int) var speed = 200
export (int) var health = 100

export (int) var width = 100

var progress = 100
var selected = false

var target = Vector2()
var velocity = Vector2()

func _ready():
	target = get_transform().get_origin()

func _input(event):
	if event.is_action_pressed('click'):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
