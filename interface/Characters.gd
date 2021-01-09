extends Control

var characters = []

func _on_GameManager_new_character(new_character):
	if new_character.faction == 0:
		characters.append(new_character)
	print(characters)
