extends Node2D

var character = preload("res://Character.tscn")

var colors = ['FFDBAC', 'F1C27D', 'E0AC69', 'C68642', '8D5524']

# counter for unique path ids
var nextPathId = 0

func _ready():
	randomize()
	spawnCharacter('Gideon', Vector2(100,100), 0, true)
	spawnCharacter('Ann', Vector2(200,50), 1)
	pass 

func spawnCharacter(name, position, faction, selected = false):
	var newCharacter = character.instance()
	newCharacter.position = position
	newCharacter.width = rand_range(0.3, 0.8)
	newCharacter.color = colors[randi()%5]
	newCharacter.faction = faction
	newCharacter.name = name
	newCharacter.selected = selected
	$Entities.add_child(newCharacter)

func showPath(path: PoolVector2Array) -> int:
	var line : Line2D = Line2D.new()
	line.points = path
	$Paths.add_child(line, nextPathId)
	nextPathId += 1
	return nextPathId-1
