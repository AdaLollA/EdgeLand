extends Node2D

# get root
## print(get_tree().root.get_child(0).name)

# Declare member variables here. Examples:
## var a = 2
## var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		print(child.name)
	print($Gear/Appearal.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
