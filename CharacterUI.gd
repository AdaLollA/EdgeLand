extends Control

func _ready():
	updateUI()

func updateUI():
	updateNameUI()
	updateHealthUI()
	updateProgressUI()

func updateNameUI():
	if get_parent().selected:
		$Name.bbcode_text = '[center]' + '[u]' + get_parent().characterName
	else:
		$Name.bbcode_text = '[center]' + get_parent().characterName

func updateHealthUI():
	$HealthBar.value = get_parent().health

func updateProgressUI():
	$ProgressBar.value = get_parent().progress
