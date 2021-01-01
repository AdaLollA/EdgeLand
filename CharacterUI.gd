extends Control

func _ready():
	updateUI()

func updateUI():
	updateNameUI()
	updateHealthUI()
	updateProgressUI()

func updateNameUI():
	var name = '[center]'
	if get_parent().selected:
		name += '[u]'
	if get_parent().faction != 0:
		name += '[color=#900000]'
	name += get_parent().characterName
	$Name.bbcode_text = name

func updateHealthUI():
	$HealthBar.value = get_parent().health

func updateProgressUI():
	$ProgressBar.value = get_parent().progress
