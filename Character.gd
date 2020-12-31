extends KinematicBody2D

# mechanical
export (int) var speed = 200
export (int) var health = 100

# visual
export var characterName = 'Name'
export (float) var width = 0.7
export (Color) var color = Color('F1C27D')
## var colors = ['FFDBAC', 'F1C27D', 'E0AC69', 'C68642', '8D5524']
## var color = colors[randi()%5]

# movement
var target = Vector2()
var velocity = Vector2()

# misc
var progress = 100
var selected = false

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
