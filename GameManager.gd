extends Node2D

var character = preload("res://Character.tscn")

var colors = ['FFDBAC', 'F1C27D', 'E0AC69', 'C68642', '8D5524']

func _ready():
	randomize()
	spawnCharacter('Gideon', Vector2(50,50), 0)
	spawnCharacter('Ann', Vector2(200,50), 1)
	pass 

func spawnCharacter(name, position, faction):
	var newCharacter = character.instance()
	newCharacter.position = position
	newCharacter.width = rand_range(0.3, 0.8)
	newCharacter.color = colors[randi()%5]
	newCharacter.faction = faction
	newCharacter.name = name
	
	$Entities.add_child(newCharacter)
