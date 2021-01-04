extends RigidBody2D

var origin: Vector2

export (int) var trail_length = 15
export (float) var max_distance = 200

var size: int = 0

# removing rogue bullet
func _on_Timer_timeout():
	queue_free()
	print('removing rogue bullet')

func _ready():
	# set origin for max range calculations
	origin = position
	# clear existing points from designer
	var factor = -$Trail.points[1].x
	for i in range(0, $Trail.points.size()):
		var scaled_down: Vector2 = $Trail.points[i] / factor
		$Trail.set_point_position(i, scaled_down)

func _physics_process(delta):
		# remove bullet when it has reached its max range
	var distance: float = (origin - position).length()
	if distance > max_distance:
		queue_free()
	
	# expand trail size
	if size < $Trail.points.size() and distance > trail_length*size:
		var point = $Trail.points[size] * trail_length
		$Trail.set_point_position(size, point)
		size += 1
		print($Trail.points)


