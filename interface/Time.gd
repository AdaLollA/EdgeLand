extends Control

func _on_PlayPause_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	if new_pause_state:
		$PlayPause.text = 'play'
	else:
		$PlayPause.text = 'pause'
