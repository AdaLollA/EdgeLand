extends Camera2D

export (float) var granularity = 0.1
export (float) var maxZoom = 1
export (float) var minZoom = 0.1

var previousDragPosition = null
var drag = false


func _input(event):
	# zoom
	if event.is_action_pressed('zoom_out') && zoom.x < maxZoom:
		zoom.x += granularity
		zoom.y += granularity
	elif event.is_action_pressed('zoom_in') && zoom.x > minZoom:
		zoom.x -= granularity
		zoom.y -= granularity
	
	# movement
	if event.is_action_pressed('camera_drag'):
		previousDragPosition = get_local_mouse_position()
		drag = true
	elif event.is_action_released('camera_drag'):
		drag = false

func _physics_process(delta):
	if drag:
		var deltaTransform = previousDragPosition - get_local_mouse_position()
		previousDragPosition = get_local_mouse_position()
		transform.origin += deltaTransform
		print(deltaTransform)

func _process(delta):
	pass
