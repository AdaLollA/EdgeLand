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

func request_task(type: int) -> Task:
	return find_next_task_of_type(type) # todo

func find_next_task_of_type(type: int) -> Task:
	for task in tasks:
		if task.type == type:
			print('assigning task: ' + task.title)
			return task
	# returning null if no matching task could be found
	return null
