extends Node2D

var character = preload("res://Character.tscn")

var colors = ['FFDBAC', 'F1C27D', 'E0AC69', 'C68642', '8D5524']

func _ready():
	randomize()
	spawnCharacter()
	pass 

func spawnCharacter():
	var newCharacter = character.instance()
	newCharacter.width = rand_range(0.3, 0.8)
	newCharacter.color = colors[randi()%5]
	$Entities.add_child(newCharacter)