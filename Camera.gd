extends Camera2D

export (float) var granularity = 0.1
export (float) var maxZoom = 1
export (float) var minZoom = 0.1

func _input(event):
	if event.is_action_pressed('zoom_out') && zoom.x < maxZoom:
		zoom.x += granularity
		zoom.y += granularity
	elif event.is_action_pressed('zoom_in') && zoom.x > minZoom:
		zoom.x -= granularity
		zoom.y -= granularity
