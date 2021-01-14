extends Node2D

var Task = preload("res://Task.gd")

var tasks = []

func _ready():
	add_task()

func add_task():
	var new_task: Task = Task.new()
	new_task.title = 'Cut Tree'
	new_task.type = Task.Type.GROW
	tasks.append(new_task)
