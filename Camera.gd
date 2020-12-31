extends Camera2D

export (float) var granularity = 0.1

func _input(event):
	if event.is_action_pressed('zoom_out') && zoom.x < 1:
		zoom.x += granularity
		zoom.y += granularity
	elif event.is_action_pressed('zoom_in') && zoom.x > 0.5:
		zoom.x -= granularity
		zoom.y -= granularity
