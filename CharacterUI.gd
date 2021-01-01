extends Control

var initializedHealthBar = false

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
	name += get_parent().characterName
	$Name.bbcode_text = name

func updateHealthUI():
	# health bar color
	var styleBox = str2var(var2str($HealthBar.get("custom_styles/fg")))
	if get_parent().faction == 0:
		# ally
		styleBox.bg_color = Color('#116b2a')
	else:
		# enemy
		styleBox.bg_color = Color('#b51f1f')
	$HealthBar.set("custom_styles/fg", styleBox)
	
	# health bar value
	$HealthBar.value = get_parent().health

func updateProgressUI():
	$ProgressBar.value = get_parent().progress
