extends KinematicBody2D

export (int) var speed = 200
export (int) var health = 100
export var characterName = 'Name'

var target = Vector2()
var velocity = Vector2()

func _ready():
	target = get_transform().get_origin()
	updateNameUI()
	updateHealthUI()

func _input(event):
	if event.is_action_pressed('click'):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

func updateNameUI():
	$Name.bbcode_text = '[center]' + characterName

func updateHealthUI():
	$HealthBar.value = health
