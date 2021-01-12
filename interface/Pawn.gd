extends MarginContainer

var pawn_name = 'Name' setget set_pawn_name

func set_pawn_name(value):
	pawn_name = value
	# todo subscribe to selcted signal to update ui with underline when needed
	$Control/NameLabel.bbcode_text = '[center]' + pawn_name

# todo mood bar setter

# todo health bar setter
