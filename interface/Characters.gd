extends Control

var pawn = preload("res://interface/Pawn.tscn")

var characters = []

func _on_GameManager_new_character(new_character):
	if new_character.faction == 0:
		characters.append(new_character)
		update_ui()

func update_ui():
	# clear old ui
	delete_children($HBoxContainer)
	
	# build new ui from scratch
	for c in characters:
		var new_pawn = pawn.instance()
		new_pawn.pawn_name = c.characterName
		$HBoxContainer.add_child(new_pawn)

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
