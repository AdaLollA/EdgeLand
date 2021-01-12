extends Node2D

var character = preload("res://entities/Character.tscn")

var colors = ['FFDBAC', 'F1C27D', 'E0AC69', 'C68642', '8D5524']

signal new_character

func _ready():
	randomize()
	spawnCharacter('Gideon', Vector2(500,200), 0, true)
	spawnCharacter('Lucie', Vector2(600,200), 0, false)
	spawnCharacter('Ann', Vector2(400,200), 1)
	pass 

func _input(event):
	# deselect all characters
	if event.is_action_pressed('ui_cancel'):
		for e in $Entities.get_children():
			e.selected = false

func spawnCharacter(name, position, faction, selected = false):
	var newCharacter = character.instance()
	newCharacter.position = position
	newCharacter.width = rand_range(0.5, 1.5)
	newCharacter.color = colors[randi()%5]
	newCharacter.faction = faction
	newCharacter.characterName = name
	newCharacter.selected = selected
	$Entities.add_child(newCharacter)
	emit_signal('new_character', newCharacter)

func showPath(path: PoolVector2Array) -> Line2D:
	var line : Line2D = Line2D.new()
	line.points = path
	line.width = 1
	line.default_color = '#212121'
	$Paths.add_child(line, true)
	return line
