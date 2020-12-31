extends KinematicBody2D

var bullet = preload("res://Bullet.tscn")

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
	fire()

func _input(event):
	if event.is_action_pressed('right_click') && selected:
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

func _on_Character_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click'):
		selected = !selected
		$CharacterUI.updateNameUI()

func fire():
	var bulletInstance = bullet.instance()
	bulletInstance.position = position + Vector2(20,0)
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(200, 0).rotated(rotation))
	get_node("/root/root/GameManager").add_child(bulletInstance)


func _on_HurtBox_body_entered(body):
	if 'Bullet' in body.name:
		print('hit')
	pass # Replace with function body.
