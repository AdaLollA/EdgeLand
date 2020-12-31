extends RigidBody2D

func _on_Timer_timeout():
	print('removing rogue bullet')
	queue_free()
