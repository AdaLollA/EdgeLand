extends Node

class_name Task

enum Type {
	GROW, MINE, HAUL,
	COOK, CONSTRUCT, CRAFT,
	DOCTOR, RECOVERY, RESEARCH
}

var type: int = -1
var title: String = ''

var max_progress = 100
var progress: int = 0
var source = null
