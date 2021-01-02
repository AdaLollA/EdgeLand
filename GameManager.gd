extends Node2D

var character = preload("res://Character.tscn")

var colors = ['FFDBAC', 'F1C27D', 'E0AC69', 'C68642', '8D5524']

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

func showPath(path: PoolVector2Array) -> Line2D:
	var line : Line2D = Line2D.new()
	line.points = path
	line.width = 1
	line.default_color = '#212121'
	$Paths.add_child(line, true)
	return line
