extends MarginContainer

var pawn_name = 'Name' setget set_pawn_name
var pawn_mood = 70 setget set_pawn_mood
var pawn_health = 70 setget set_pawn_health

func set_pawn_name(value):
	pawn_name = value
	# todo subscribe to selcted signal to update ui with underline when needed
	$Control/NameLabel.bbcode_text = '[center]' + pawn_name

func set_pawn_mood(value):
	pawn_mood = value
	# todo subscribe to mood change signal
	$Control/MoodBar.value = pawn_mood

func set_pawn_health(value):
	pawn_health = value
	# todo subscribe to mood change signal
	$Control/HealthBar.value = pawn_health
