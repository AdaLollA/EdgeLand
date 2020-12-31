extends KinematicBody2D

# mechanical
export (int) var faction = 0
export (int) var speed = 200
export (int) var health = 100

# visual
export var characterName = 'Name'
export (float) var width = 0.7
export (Color) var color = Color('F1C27D')

# movement
var target = Vector2()
var velocity = Vector2()

# misc
var progress = 100
var selected = false

func _ready():
	target = get_transform().get_origin()

func _input(event):
	if event.is_action_pressed('click') && selected:
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

func _on_Character_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click'):
		print('clicked')
		selected = !selected
		$CharacterUI.updateNameUI()
	pass # Replace with function body.
